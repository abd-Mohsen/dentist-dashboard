import 'package:dentist_dashboard/controllers/category/add_category_controller.dart';
import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:dentist_dashboard/views/components/custom_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBrandView extends StatelessWidget {
  const AddBrandView({super.key});

  @override
  Widget build(BuildContext context) {
    AddCategoryController aCC = Get.put(AddCategoryController());
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    topBar() => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.delete<AddCategoryController>();
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

    image() => GetBuilder<AddCategoryController>(
          builder: (con) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: con.isNewImgSelected
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height / 2,
                          width: double.infinity,
                          child: Image.memory(con.newImg),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          con.pickImage();
                        },
                        child: Text("choose another".tr),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: InkWell(
                      onTap: () {
                        con.pickImage();
                      }, // todo: crop the pic to match the aspect ratio in backend
                      child: DottedBorder(
                        color: cs.onSurface.withOpacity(0.6),
                        strokeWidth: 3,
                        dashPattern: const [5, 5],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 50,
                                  color: cs.onSurface,
                                ),
                                Text(
                                  'add image'.tr,
                                  style: tt.headlineSmall!.copyWith(color: cs.onSurface),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        );

    List<Widget> contents = [
      GetBuilder<AddCategoryController>(
        builder: (con) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomField(
                iconData: Icons.label,
                controller: aCC.title,
                title: "title".tr,
                hint: "add a title".tr,
                onChanged: (s) {
                  if (aCC.buttonPressed) aCC.addCategoryFormKey.currentState!.validate();
                },
                validator: (s) {
                  return validateInput(s!, 4, 100, "title");
                },
              ),
              //todo: drop down search
            ],
          ),
        ),
      )
    ];

    bottomBar() => GetBuilder<AddCategoryController>(
          builder: (con) => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    con.addCategory();
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
                          Text("save".tr, style: tt.titleMedium!.copyWith(color: cs.onPrimary)),
                          const SizedBox(width: 8),
                          Icon(Icons.add, color: cs.onPrimary),
                        ],
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
        Get.delete<AddCategoryController>();
        //pC.dispose();
        return true;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: GetBuilder<AddCategoryController>(
          builder: (con) => Form(
            key: con.addCategoryFormKey,
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
                          image(),
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
                            child: image(),
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
