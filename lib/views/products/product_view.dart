import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dentist_dashboard/controllers/product_controller.dart';
import 'package:dentist_dashboard/models/product_model.dart';
import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    ProductController pC = Get.put(ProductController());
    CarouselController sliderController = CarouselController();
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    imageSlider() => GetBuilder<ProductController>(
          builder: (con) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CarouselSlider(
                    carouselController: sliderController,
                    items: [
                      ...product.images
                          .map(
                            (image) => CachedNetworkImage(
                              imageUrl: "$kHostIP/${Uri.encodeComponent(image.path)}",
                              //height: 350,
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
                      height: MediaQuery.sizeOf(context).height / 1.5,
                      //aspectRatio: 16 / 10,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      onPageChanged: (i, reason) => con.changeIndex(i),
                    ),
                  ),
                  Positioned.fill(
                    left: -1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          sliderController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: cs.onSurface,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              AnimatedSmoothIndicator(
                activeIndex: con.imageIndex,
                count: product.images.length,
                effect: WormEffect(dotHeight: 9, dotWidth: 9, activeDotColor: cs.primary),
              )
            ],
          ),
        );
    topBar() => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.delete<ProductController>();
                  //pC.dispose();
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
        );
    contents() => Column();

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
            child: ResponsiveWidget.isSmall(context)
                ? ListView(
                    children: [
                      topBar(),
                      imageSlider(),
                      Divider(
                        indent: 15,
                        endIndent: 15,
                        thickness: 2,
                        //width: 36,
                        color: cs.onSurface.withOpacity(0.5),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      const SizedBox(width: 18),
                      Expanded(
                        child: imageSlider(),
                      ),
                      VerticalDivider(
                        indent: 30,
                        endIndent: 30,
                        thickness: 2,
                        width: 36,
                        color: cs.onSurface.withOpacity(0.5),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            topBar(),
                            Expanded(
                              child: contents(),
                            ),
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
