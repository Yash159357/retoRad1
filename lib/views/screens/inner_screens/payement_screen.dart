import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reto_radiance/provider/cart_provider.dart';
import 'package:reto_radiance/views/screens/main_screen.dart';
import 'package:uuid/uuid.dart';

class RazorPayPage extends ConsumerStatefulWidget {
  const RazorPayPage({Key? key, required this.amount, required this.discount})
    : super(key: key);
  final double amount;
  final double discount;

  @override
  ConsumerState<RazorPayPage> createState() => _RazorPayPageState();
}

class _RazorPayPageState extends ConsumerState<RazorPayPage> {
  late Razorpay _razorpay;
  late final TextEditingController _amountController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.amount.toStringAsFixed(2),
    );
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
  }

  void openCheckout() {
    final paymentAmount = (widget.amount * 100).toInt();
    // var options = {
    //   'key': 'rzp_test_1DP5mmOlF5G5ag',
    //   'amount': paymentAmount,
    //   'name': "Trial Name",
    //   'prefill': {'contact': "9876543210", 'email': 'trial@gmail.com'},
    //   'external': {
    //     'wallets': ['paytm'],
    //   },
    // };
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': paymentAmount,
      'name': "RETOAPP",
      'prefill': {
        'contact': "9876543210", // Must be real number
        'email': 'user@email.com',
      },
      'external': {
        'wallets': ['phonepe', 'paytm'], // Explicitly list UPI apps
      },
      // 'notes': {
      //   'udf1':
      //       'user_id_${_auth.currentUser?.uid}', // Required for some UPI apps
      // },
      // 'theme': {
      //   'color': '#F8BA5E',
      //   'hide_topbar': true, // Helps with UPI app rendering
      // },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment Error: ${e.toString()}')),
        );
      }
    }
  }

  void paymentSuccess(PaymentSuccessResponse response) async {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment Successful: ${response.paymentId}'),
        duration: const Duration(seconds: 1),
      ),
    );

    try {
      final cartItems =
          ref.read(cartProvider.notifier).getCartItem.values.toList();
      final userDoc =
          await _firestore
              .collection('customers')
              .doc(_auth.currentUser!.uid)
              .get();

      final CollectionReference orderRefer = _firestore.collection('orders');
      final batch = _firestore.batch();

      for (var item in cartItems) {
        final orderId = const Uuid().v4();
        final orderRef = orderRefer.doc(orderId);

        // Ensure correct price calculation (adjust based on your logic)
        double price = (item.quantity * item.discount) * (1 - widget.discount);

        batch.set(orderRef, {
          'orderId': orderId,
          'productName': item.productName,
          'productId': item.productId,
          'size': item.productSize,
          'quantity': item.quantity,
          'price': price,
          'category': item.category,
          'productImage': item.productImage[0],
          'name': userDoc['name'],
          'email': userDoc['email'],
          'number': userDoc['number'],
          'customerId': _auth.currentUser!.uid,
          'state': userDoc['state'],
          'city': userDoc['city'],
          'locality': userDoc['locality'],
          'pinCode': userDoc['pinCode'],
          'deliveredCount': 0,
          'delivered': false,
          'processing': true,
          'vendorId': item.vendorId,
        });
      }

      await batch.commit();

      // Clear cart only after successful commit
      ref.read(cartProvider.notifier).clearCartData();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen(index: 1)),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        print(e);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save order: $e')));
        // Optionally, handle retry or keep the cart items
      }
    }
  }

  void paymentFailure(PaymentFailureResponse response) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment Failed: ${response.message ?? 'Unknown error'}'),
        duration: const Duration(seconds: 1),
      ),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen(index: 1)),
      (route) => false,
    );
  }

  void externalWallet(ExternalWalletResponse response) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Wallet Selected: ${response.walletName}'),
        duration: const Duration(seconds: 1),
      ),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen(index: 1)),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Razorpay Payment",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(210, 248, 186, 94),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: TextFormField(
            controller: _amountController,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromARGB(210, 248, 186, 94),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromARGB(210, 248, 186, 94),
                  width: 2.0,
                ),
              ),
              hintText: "Amount",
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 18),
              prefixIcon: Icon(
                Icons.currency_rupee_rounded,
                color: Colors.grey.shade600,
                size: 30,
              ),
            ),
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(color: Colors.grey.shade500, indent: 8, endIndent: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  if (widget.amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid amount provided')),
                    );
                    return;
                  }
                  openCheckout();
                },
                child: Container(
                  height: screenHeight * 0.065,
                  width: screenWidth,
                  margin: const EdgeInsets.only(bottom: 12, top: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(210, 248, 186, 94),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(25),
                      right: Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Pay ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Icon(
                          Icons.currency_rupee_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                        Text(
                          widget.amount.toStringAsFixed(2),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
