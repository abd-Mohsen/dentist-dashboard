import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dentist_dashboard/controllers/brand_controller.dart';
import 'package:dentist_dashboard/controllers/product_controller.dart';
import 'package:dentist_dashboard/models/brand_model.dart';
import 'package:dentist_dashboard/models/product_model.dart';
import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants.dart';

class BrandView extends StatelessWidget {
  const BrandView({super.key, required this.brand});
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    ProductController pC = Get.put(ProductController());
    CarouselController sliderController = CarouselController();
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

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
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              enabled: false,
              initialValue: brand.title,
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.only(right: 12, left: 8),
                  child: Icon(Icons.title),
                ),
                border: OutlineInputBorder(),
                // labelText: "title",
                // labelStyle: tt.bodyLarge,
                // label: Text(
                //   "title",
                //   style: tt.bodyLarge,
                // ),
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                //disabledBorder: null,
              ),
              style: tt.titleMedium,
            ),
          ],
        ),
      )
    ];

    return WillPopScope(
      onWillPop: () async {
        Get.delete<BrandController>();
        //pC.dispose();
        return true;
      },
      child: Dialog(
        child: GetBuilder<BrandController>(
          builder: (con) => Form(
            key: con.brandFormKey,
            child: Container(
              height: MediaQuery.sizeOf(context).height / 1.3,
              width: MediaQuery.sizeOf(context).width / 1.3,
              child: ResponsiveWidget.isSmall(context)
                  ? ListView(
                      children: [
                        topBar(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl: "$kHostIP/${Uri.encodeComponent(brand.image)}",
                          ),
                        ),
                        Divider(
                          indent: 15,
                          endIndent: 15,
                          thickness: 2,
                          //width: 36,
                          color: cs.onSurface.withOpacity(0.5),
                        ),
                        ...contents,
                      ],
                    )
                  : Row(
                      children: [
                        const SizedBox(width: 18),
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: "$kHostIP/${Uri.encodeComponent(brand.image)}",
                          ),
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
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
