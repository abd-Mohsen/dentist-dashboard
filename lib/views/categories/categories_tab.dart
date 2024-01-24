import 'package:dentist_dashboard/controllers/category/add_category_controller.dart';
import 'package:dentist_dashboard/controllers/category/categories_tab_controller.dart';
import 'package:dentist_dashboard/views/brands/add_brand_view.dart';
import 'package:dentist_dashboard/views/categories/add_category_view.dart';
import 'package:dentist_dashboard/views/components/my_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: GetBuilder<CategoriesTabController>(
        init: CategoriesTabController(),
        builder: (con) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 72.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ListView(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.put(AddCategoryController());
                        showDialog(
                          context: context,
                          //barrierDismissible: false,
                          builder: (context) => const AddCategoryView(),
                        );
                      },
                      mouseCursor: MaterialStateMouseCursor.clickable,
                      child: ListTile(
                        leading: Icon(
                          Icons.add,
                          size: 35,
                          color: cs.onPrimary,
                        ),
                        title: Text(
                          "add a category".tr,
                          style: tt.headlineMedium!.copyWith(color: cs.onPrimary),
                        ),
                        tileColor: cs.primary,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: MySearchBar(
                textEditingController: con.searchController,
                focusNode: con.searchFocusNode,
                scrollController: con.suggestionsScrollController,
                onTapField: () => con.toggleSearchState(true),
                onTapClear: () {
                  con.searchController.text = "";
                  con.toggleSearchState(true);
                },
                onTapOutsideField: (e) async {
                  await Future.delayed(const Duration(milliseconds: 600));
                  con.toggleSearchState(false);
                },
                onQueryChange: (s) => con.search(),
                searchResult: con.searchResult,
                suggestionsVisible: con.searchEnabled && con.searchController.text != "",
                hint: "search for a category by title".tr,
                type: 'category',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
