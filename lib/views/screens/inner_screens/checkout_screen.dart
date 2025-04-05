import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reto_radiance/models/cart_models.dart';
import 'package:reto_radiance/provider/cart_provider.dart';
import 'package:reto_radiance/views/screens/inner_screens/shipping_address_screen.dart';
import 'package:reto_radiance/views/screens/main_screen.dart';
import 'package:uuid/uuid.dart';

// Create a service class to handle Firebase operations
class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID with null safety
  String? get currentUserId => _auth.currentUser?.uid;

  // Get user data stream
  Stream<DocumentSnapshot> getUserDataStream(String userId) {
    return _firestore.collection('customers').doc(userId).snapshots();
  }

  // Check inventory availability
  Future<Map<String, String>> checkInventoryAvailability(
    List<CartModel> cartItems,
  ) async {
    Map<String, String> unavailableItems = {};

    try {
      // Create list of product IDs from cart items
      final List<String> productIds = cartItems.map((item) => item.productId).toList();
      
      // Handle empty cart case
      if (productIds.isEmpty) {
        return unavailableItems;
      }

      // Split into chunks if needed (Firestore has a limit of 10 items in 'whereIn')
      final List<List<String>> chunks = [];
      for (var i = 0; i < productIds.length; i += 10) {
        chunks.add(
          productIds.sublist(
            i, 
            i + 10 < productIds.length ? i + 10 : productIds.length
          )
        );
      }

      // Map to store all product data
      final Map<String, Map<String, dynamic>> productsMap = {};

      // Query Firestore for each chunk
      for (final chunk in chunks) {
        final QuerySnapshot productSnapshot = await _firestore
            .collection('products')
            .where('productId', whereIn: chunk)
            .get();

        // Add documents to the map
        for (var doc in productSnapshot.docs) {
          productsMap[doc.get('productId')] = doc.data() as Map<String, dynamic>;
        }
      }

      // Check each cart item against available inventory
      for (var cartItem in cartItems) {
        // If product doesn't exist
        if (!productsMap.containsKey(cartItem.productId)) {
          unavailableItems[cartItem.productId] = 
              "${cartItem.productName} is no longer available";
          continue;
        }

        final productData = productsMap[cartItem.productId]!;

        // Check if product is sold out
        if (productData['isSoldOut'] == true) {
          unavailableItems[cartItem.productId] = 
              "${cartItem.productName} is out of stock";
          continue;
        }

        // Check if requested quantity exceeds available quantity
        final int availableQuantity = productData['quantity'] ?? 0;
        if (cartItem.quantity > availableQuantity) {
          unavailableItems[cartItem.productId] =
              "Only $availableQuantity ${cartItem.productName} available (you requested ${cartItem.quantity})";
        }
      }
    } catch (e) {
      print("Error checking inventory: $e");
      // Return a generic error for all items in case of exception
      for (var item in cartItems) {
        unavailableItems[item.productId] = 
            "Unable to verify availability of ${item.productName}";
      }
    }

    return unavailableItems;
  }

  // Place order with transaction handling
  Future<bool> placeOrder({
    required List<CartModel> cartItems,
    required Map<String, dynamic> userData,
    required Function(String) onError,
    required double discount,
  }) async {
    // Check for current user
    final userId = currentUserId;
    if (userId == null) {
      onError("User not authenticated");
      return false;
    }

    try {
      // Check inventory first
      final unavailableItems = await checkInventoryAvailability(cartItems);
      if (unavailableItems.isNotEmpty) {
        String errorMessage = '';
        unavailableItems.values.forEach((message) {
          errorMessage += '• $message\n';
        });
        onError(errorMessage);
        return false;
      }

      // Create batch for atomic operations
      final batch = _firestore.batch();
      
      // Map to track product quantity updates
      Map<String, int> productQuantityUpdates = {};

      // Reference to orders collection
      final CollectionReference orderRefer = _firestore.collection('orders');
      
      // Add each order to batch
      for (var item in cartItems) {
        final orderId = const Uuid().v4();
        final orderRef = orderRefer.doc(orderId);
        
        // Calculate final price with discount
        final finalPrice = (item.quantity * item.discount) * (1 - discount);

        batch.set(orderRef, {
          'orderId': orderId,
          'productName': item.productName,
          'productId': item.productId,
          'size': item.productSize,
          'quantity': item.quantity,
          'price': finalPrice,
          'category': item.category,
          'productImage': item.productImage.isNotEmpty ? item.productImage[0] : '',
          'name': userData['name'] ?? '',
          'email': userData['email'] ?? '',
          'number': userData['number'] ?? '',
          'customerId': userId,
          'state': userData['state'] ?? '',
          'city': userData['city'] ?? '',
          'locality': userData['locality'] ?? '',
          'pinCode': userData['pinCode'] ?? '',
          'deliveredCount': 0,
          'delivered': false,
          'processing': true,
          'vendorId': item.vendorId,
          'createdAt': FieldValue.serverTimestamp(),
        });
        
        // Update product quantity tracking
        productQuantityUpdates[item.productId] = 
            (productQuantityUpdates[item.productId] ?? 0) + item.quantity;
      }

      // Reference to products collection
      final productsRefer = _firestore.collection('products');
      
      // Update product quantities in the batch
      productQuantityUpdates.forEach((productId, quantityToReduce) {
        final productRef = productsRefer.doc(productId);
        
        // Use increment to safely update quantity
        batch.update(productRef, {
          'quantity': FieldValue.increment(-quantityToReduce),
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      });

      // Commit batch
      await batch.commit();

      // Run transactions to update soldOut status
      for (String productId in productQuantityUpdates.keys) {
        await _firestore.runTransaction((transaction) async {
          final productDoc = await transaction.get(productsRefer.doc(productId));
          
          if (productDoc.exists) {
            final currentQuantity = productDoc.get('quantity') ?? 0;
            
            // If quantity is zero or less, mark as sold out
            if (currentQuantity <= 0) {
              transaction.update(
                productsRefer.doc(productId),
                {'isSoldOut': true},
              );
            }
          }
        });
      }
      
      return true;
    } catch (e) {
      onError("Order placement failed: ${e.toString()}");
      return false;
    }
  }
}

// Create error handler utility
class ErrorHandler {
  static void showErrorDialog(
    BuildContext context, 
    {required String title, required String message, Function()? onDismiss}
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onDismiss != null) onDismiss();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showSnackBar(
    BuildContext context, 
    {required String message, bool isError = false}
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.grey,
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

// Coupon service to handle discount logic
class CouponService {
  // Define your coupon codes and discounts
  static const Map<String, double> couponCodes = {
    'RETO10': 0.10,
    'SUMMER25': 0.25,
    'WELCOME15': 0.15,
  };

  static double getDiscountForCode(String code) {
    return couponCodes[code.toUpperCase()] ?? 0.0;
  }

  static bool isValidCode(String code) {
    return couponCodes.containsKey(code.toUpperCase());
  }
}

// Main CheckoutScreen widget
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key, required this.totalPrice});
  final double totalPrice;

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  // Services
  final FirebaseService _firebaseService = FirebaseService();
  
  // State variables
  String _selectedPaymentMethod = 'cashOnDelivery';
  final TextEditingController _couponController = TextEditingController();
  bool _isApplied = false;
  double _discount = 0;
  bool _isLoading = false;
  
  // Address data
  String _state = '';
  String _city = '';
  String _locality = '';
  String _pinCode = '';
  Map<String, dynamic> _userData = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  // Load user data from Firestore
  void _loadUserData() {
    final userId = _firebaseService.currentUserId;
    if (userId == null) {
      ErrorHandler.showSnackBar(
        context, 
        message: 'User authentication failed. Please login again.',
        isError: true,
      );
      return;
    }

    _firebaseService.getUserDataStream(userId).listen(
      (userData) {
        if (userData.exists) {
          setState(() {
            _userData = userData.data() as Map<String, dynamic>;
            _state = _userData['state'] ?? '';
            _city = _userData['city'] ?? '';
            _locality = _userData['locality'] ?? '';
            _pinCode = _userData['pinCode'] ?? '';
          });
        }
      },
      onError: (error) {
        ErrorHandler.showSnackBar(
          context, 
          message: 'Failed to load user data: $error',
          isError: true,
        );
      }
    );
  }

  // Apply coupon code
  void _applyCoupon() {
    final code = _couponController.text.trim();
    if (CouponService.isValidCode(code)) {
      final discount = CouponService.getDiscountForCode(code);
      ErrorHandler.showSnackBar(
        context,
        message: '${(discount * 100).toInt()}% discount applied!',
      );
      setState(() {
        _discount = discount;
        _isApplied = true;
      });
    } else {
      ErrorHandler.showSnackBar(
        context,
        message: 'Invalid coupon code',
        isError: true,
      );
      setState(() {
        _discount = 0;
        _isApplied = false;
      });
    }
  }

  // Process order
  Future<void> _processOrder() async {
    if (_state.isEmpty) {
      ErrorHandler.showSnackBar(
        context,
        message: 'Please add your shipping address first',
        isError: true,
      );
      return;
    }

    // Show confirmation dialog for COD
    final bool? confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Confirm Order"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("You are choosing Cash on Delivery method."),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 12),
                children: [
                  TextSpan(text: "By confirming, you agree that "),
                  TextSpan(
                    text: "fraudulent or fake orders ",
                    style: TextStyle(color: Colors.red),
                  ),
                  TextSpan(
                    text: "may lead to legal proceedings under Section 420 of IPC ",
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("CONFIRM"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);
    
    try {
      final cartItems = ref.read(cartProvider.notifier).getCartItem.values.toList();
      
      // Place order
      final success = await _firebaseService.placeOrder(
        cartItems: cartItems,
        userData: _userData,
        discount: _discount,
        onError: (errorMessage) {
          ErrorHandler.showErrorDialog(
            context,
            title: 'Order Failed',
            message: 'Some items in your cart are unavailable:\n\n$errorMessage\n\nPlease update your cart and try again.',
          );
        },
      );

      if (success) {
        // Clear cart on success
        ref.read(cartProvider.notifier).clearCartData();
        
        // Navigate to main screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen(index: 1)),
          (route) => false,
        );
        
        ErrorHandler.showSnackBar(context, message: 'Order Has Been Placed');
      }
    } catch (e) {
      ErrorHandler.showSnackBar(
        context,
        message: 'An unexpected error occurred: $e',
        isError: true,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Build coupon input row
  Widget _buildCouponRow() {
    final couponColor = const Color.fromARGB(210, 248, 186, 94);

    final InputDecoration couponDecoration = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: couponColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: couponColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: couponColor, width: 2.0),
      ),
      hintText: 'Enter coupon code',
      hintStyle: TextStyle(color: Colors.grey[600]),
    );

    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: couponColor,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150,
          child: TextField(
            controller: _couponController,
            decoration: couponDecoration,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: elevatedButtonStyle,
          onPressed: _applyCoupon,
          child: const Text(
            'Apply',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  // Build address card
  Widget _buildAddressCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ShippingAddressScreen(),
          ),
        ).then((_) => _loadUserData()); // Refresh data when returning
      },
      child: SizedBox(
        width: 335,
        height: 74,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background container
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 335,
                height: 74,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 246, 233),
                  border: Border.all(color: const Color(0xFFEFF0F2)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            // Address text
            Positioned(
              left: 70,
              top: 17,
              child: SizedBox(
                width: 215,
                height: 42,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _state.isEmpty ? 'Add Address' : 'Update Address',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _state.isNotEmpty ? '$_city, $_state - $_pinCode' : 'Enter City',
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xFF7F808C),
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Location icon
            Positioned(
              left: 16,
              top: 16,
              child: Container(
                width: 43,
                height: 43,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF7F5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    const Positioned(
                      left: 11,
                      top: 11,
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: Color.fromARGB(210, 248, 186, 94),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Edit icon
            const Positioned(
              left: 305,
              top: 25,
              child: Icon(
                Icons.edit_outlined,
                size: 20,
                color: Color.fromARGB(210, 248, 186, 94),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build cart item widget
  Widget _buildCartItem(CartModel cartItem) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 70,
              height: 70,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(color: Color(0xFFBCC5FF)),
              child: cartItem.productImage.isNotEmpty
                  ? Image.network(
                      cartItem.productImage[0],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => 
                          const Icon(Icons.image_not_supported),
                    )
                  : const Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(width: 6),
          // Product details
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  cartItem.productName,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  cartItem.category,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (cartItem.productSize.isNotEmpty)
                  Text(
                    "Size: ${cartItem.productSize}",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                Text(
                  "Quantity: ${cartItem.quantity}",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Price
          Column(
            children: [
              const SizedBox(height: 10),
              Text(
                "₹${(cartItem.discount * cartItem.quantity).toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.watch(cartProvider);
    final cartItems = cartProviderData.values.toList();
    final double discountedTotal = widget.totalPrice * (1.0 - _discount);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 28),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 250, 225, 188),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Shipping Address Section
                  _buildAddressCard(),
                  
                  const SizedBox(height: 15),
                  
                  // Items Header
                  const Text(
                    'Your Item(s)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // Items List Section
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withAlpha(150)),
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 255, 246, 233),
                    ),
                    padding: const EdgeInsets.all(8),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.36,
                    ),
                    child: cartItems.isEmpty
                        ? const Center(
                            child: Text(
                              'Your cart is empty',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) => _buildCartItem(cartItems[index]),
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.grey.shade300,
                              indent: 5,
                              endIndent: 5,
                            ),
                            itemCount: cartItems.length,
                          ),
                  ),
                  
                  const SizedBox(height: 14),
                  
                  // Coupon Section
                  _buildCouponRow(),
                  
                  const SizedBox(height: 10),
                  
                  // Total Price Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Total Price: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "₹${widget.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: _isApplied ? FontWeight.normal : FontWeight.bold,
                              decoration: _isApplied ? TextDecoration.lineThrough : TextDecoration.none,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (_isApplied)
                            Text(
                              "₹${discountedTotal.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  
                  const Divider(color: Colors.black12, height: 24),
                  
                  // Payment Options Section
                  const Text(
                    'Choose Payment Method',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  RadioListTile<String>(
                    title: const Text('Cash on Delivery'),
                    value: 'cashOnDelivery',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() => _selectedPaymentMethod = value);
                      }
                    },
                  ),
                  
                  const SizedBox(height: 100), // Space for bottomSheet
                ],
              ),
            ),
          ),
        ),
      ),
      // Place Order Button Section
      bottomSheet: Container(
        color: const Color.fromARGB(255, 250, 225, 188),
        padding: const EdgeInsets.all(25.0),
        child: _state.isEmpty
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(210, 248, 186, 94),
                  foregroundColor: Colors.white,
                  minimumSize: Size(MediaQuery.of(context).size.width - 50, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShippingAddressScreen(),
                    ),
                  ).then((_) => _loadUserData());
                },
                child: const Text(
                  'ADD ADDRESS',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : InkWell(
                onTap: _isLoading ? null : _processOrder,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(210, 248, 186, 94),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'PLACE YOUR ORDER',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                          ),
                  ),
                ),
              ),
      ),
    );
  }
}