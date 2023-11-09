import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dentist_dashboard/controllers/home_controller.dart';
import 'package:dentist_dashboard/controllers/product_controller.dart';
import 'package:dentist_dashboard/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:io';
import '../../constants.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    ProductController pC = Get.put(ProductController()); //todo: dispose
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () async {
        Get.delete<ProductController>();
        return true;
      },
      child: Dialog(
        child: GetBuilder<ProductController>(
          builder: (con) => Container(
            height: MediaQuery.sizeOf(context).height / 1.3,
            width: MediaQuery.sizeOf(context).width / 1.3,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CarouselSlider(
                              items: [
                                ...product.images
                                    .map(
                                      (image) => CachedNetworkImage(
                                        imageUrl: "$kHostIP/${Uri.encodeComponent(image.path)}",
                                        height: 500,
                                      ),
                                    )
                                    .toList(),
                                // Container(
                                //   width: 170,
                                //   height: 170,
                                //   decoration: BoxDecoration(
                                //     border: Border.all(
                                //       color: Colors.grey,
                                //       width: 1.0,
                                //     ),
                                //     borderRadius: BorderRadius.circular(8.0),
                                //   ),
                                //   child: const Center(
                                //     child: Icon(
                                //       Icons.add_photo_alternate_outlined,
                                //       size: 40,
                                //       color: Colors.grey,
                                //     ),
                                //   ),
                                // ),
                              ],
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                //aspectRatio: 4 / 3,
                                onPageChanged: (i, reason) => con.changeIndex(i),
                              ),
                            ),
                            const SizedBox(height: 8),
                            AnimatedSmoothIndicator(
                              activeIndex: con.imageIndex,
                              count: product.images.length,
                              effect: WormEffect(dotHeight: 9, dotWidth: 9, activeDotColor: cs.primary),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Get.delete<ProductController>();
                                Get.back();
                              },
                              child: Icon(
                                Icons.close,
                                color: cs.error,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(),
                      Row(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
