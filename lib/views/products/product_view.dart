import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dentist_dashboard/controllers/product_controller.dart';
import 'package:dentist_dashboard/models/product_model.dart';
import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants.dart';
import '../components/custom_field.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    ProductController pC = Get.put(ProductController(product: product));
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
                      height: ResponsiveWidget.isSmall(context)
                          ? MediaQuery.sizeOf(context).height / 2
                          : MediaQuery.sizeOf(context).height / 1.5,
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

    List<Widget> contents = [
      GetBuilder<ProductController>(
        builder: (con) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomField(
                iconData: Icons.label,
                controller: pC.title,
                title: "title",
                enabled: con.editingMode,
                onChanged: (s) {
                  if (con.buttonPressed) con.productFormKey.currentState!.validate();
                },
                validator: (s) {
                  return validateInput(s!, 4, 100, "title");
                },
              ),
              // todo: make description a text area
              CustomField(
                iconData: Icons.description,
                controller: pC.description,
                title: "description".tr,
                enabled: con.editingMode,
                onChanged: (s) {
                  if (con.buttonPressed) con.productFormKey.currentState!.validate();
                },
                validator: (s) {
                  return validateInput(s!, 4, 100, "");
                },
              ),
              CustomField(
                iconData: Icons.monetization_on,
                controller: pC.price,
                title: "price".tr,
                enabled: con.editingMode,
                onChanged: (s) {
                  if (con.buttonPressed) con.productFormKey.currentState!.validate();
                },
                validator: (s) {
                  return validateInput(s!, 4, 100, "number");
                },
              ),
            ],
          ),
        ),
      )
    ];

    bottomBar() => GetBuilder<ProductController>(
          builder: (con) => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: !con.editingMode,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        title: 'warning'.tr,
                        middleText: 'do you wanna delete this brand?'.tr,
                        textConfirm: 'yes',
                        textCancel: 'no',
                        onConfirm: () {
                          //con.deleteCategory();
                          Get.back();
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                        child: Row(
                          children: [
                            Text("delete".tr, style: tt.titleMedium!.copyWith(color: cs.onPrimary)),
                            const SizedBox(width: 8),
                            Icon(Icons.delete, color: cs.onPrimary),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !con.editingMode,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      con.toggleEditMode(true);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: cs.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                        child: Row(
                          children: [
                            Text("edit".tr, style: tt.titleMedium!.copyWith(color: cs.onPrimary)),
                            const SizedBox(width: 8),
                            Icon(Icons.edit, color: cs.onPrimary),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: con.editingMode,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: InkWell(
                    onTap: () {
                      Get.delete<ProductController>();
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("cancel".tr, style: tt.titleMedium!.copyWith(color: cs.onPrimary)),
                            const SizedBox(width: 8),
                            Icon(Icons.clear, color: cs.onPrimary),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: con.editingMode,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: InkWell(
                    onTap: () {
                      //con.editCategory();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("ok".tr, style: tt.titleMedium!.copyWith(color: cs.onPrimary)),
                            const SizedBox(width: 8),
                            Icon(Icons.check, color: cs.onPrimary),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

    return WillPopScope(
      onWillPop: () async {
        Get.delete<ProductController>();
        return true;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: GetBuilder<ProductController>(
          builder: (con) => Form(
            key: con.productFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height / 1.3,
                width: MediaQuery.sizeOf(context).width / 1.3,
                child: ResponsiveWidget.isSmall(context)
                    ? ListView(
                        //padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                          ...contents,
                          bottomBar(),
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
                                  child: ListView(
                                    children: contents,
                                  ),
                                ),
                                bottomBar(),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
