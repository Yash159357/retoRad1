import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reto_radiance/controllers/category_controller.dart';
import 'package:reto_radiance/views/screens/inner_screens/category_product_screen.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  final CategoryController _categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    // print(3);
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start, //It will start our Column Contents horizontally

          children: [
            // Center(
            //   child: Text(
            //     'Reto Trending',
            //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // SizedBox(height: 10),

            //This Grid View will show our items in a Grid View
            GridView.builder(
              shrinkWrap:
                  true, //'shrinkWrap' enables a container to occupy only the space necessary to hold its children.

              physics:
                  const NeverScrollableScrollPhysics(), //In Flutter, 'NeverScrollableScrollPhysics()' is a scroll physics class that completely disables scrolling on a widget, preventing users from interacting with it by scrolling

              itemCount:
                  _categoryController
                      .categories
                      .length, //'itemCount' decides the number of items in our row and here it is the number of categories we are having in our Firebase.

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing:
                    4, //This 'mainAxisSpacing' will decide the spacing vertically.
                crossAxisSpacing:
                    8, //This 'crossAxisSpacing' will decide the spacing horizontally between 2 categories.
                crossAxisCount:
                    4, //This 'crossAxisCount' will decide how many items will be shown in a row.
              ),

              //This section will show that how we intent to display our categories
              itemBuilder: (context, index) {
                return InkWell(
                  //'InkWell' because we want our categories to be clickable
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CategoryProductScreen(
                            categoryModel:
                                _categoryController.categories[index],
                          );
                        },
                      ),
                    );
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 242, 242),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        //Fetching our Category Image
                        SizedBox(height: 10),
                        CachedNetworkImage(
                          imageUrl:
                              _categoryController
                                  .categories[index]
                                  .categoryImage,
                          width: 47, //Width of each category image
                          height: 47, //Height of each category image
                          fit:
                              BoxFit
                                  .cover, //This will make our each category image to cover the each grid box entirely.
                        ),

                        //Fetching our Category Name
                        Text(
                          _categoryController.categories[index].categoryName,
                          style: GoogleFonts.quicksand(
                            //Styling our Category Name and specifying our Google Font as well
                            fontSize: 14, //Font Size of our Category Name
                            letterSpacing:
                                0.3, //Spacing between letters of our Category Name
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
