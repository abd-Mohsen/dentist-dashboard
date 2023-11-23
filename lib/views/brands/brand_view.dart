import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentist_dashboard/controllers/brand_controller.dart';
import 'package:dentist_dashboard/controllers/product_controller.dart';
import 'package:dentist_dashboard/models/brand_model.dart';
import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:dentist_dashboard/views/components/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';

class BrandView extends StatelessWidget {
  const BrandView({super.key, required this.brand});
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    BrandController bC = Get.put(BrandController(brand: brand));
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    topBar() => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.delete<BrandController>();
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
      GetBuilder<BrandController>(
        builder: (con) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomField(
                controller: bC.title,
                title: "title",
                enabled: con.editingMode,
              ),
              CustomField(
                controller: bC.title,
                title: "title",
                enabled: con.editingMode,
              ),
              CustomField(
                controller: bC.title,
                title: "title",
                enabled: con.editingMode,
              ),
            ],
          ),
        ),
      )
    ];
    bottomBar() => GetBuilder<BrandController>(
          builder: (con) => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                        padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.delete<BrandController>();
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
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      //todo: send request
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
                        bottomBar(),
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
    );
  }
}
