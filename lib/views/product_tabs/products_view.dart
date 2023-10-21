import 'package:dentist_dashboard/controllers/products_tab_controller.dart';
import 'package:dentist_dashboard/models/product_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        children: [
          GetBuilder<ProductsTabController>(
            init: ProductsTabController(),
            builder: (con) => Column(
              children: [
                TextField(
                  controller: con.searchController,
                  focusNode: con.searchFocusNode,
                  onTap: () => con.toggleSearchState(true),
                  onTapOutside: (e) {
                    con.toggleSearchState(false);
                    con.searchFocusNode.unfocus();
                  },
                  onChanged: (s) {
                    con.search();
                  },
                  style: tt.labelLarge!.copyWith(color: cs.onBackground),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: con.searchEnabled
                          ? const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          : BorderRadius.circular(20),
                    ),
                    hintText: "search for a product by title".tr,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: con.searchEnabled
                        ? IconButton(
                            onPressed: () {
                              con.searchController.text = "";
                              con.toggleSearchState(true);
                            },
                            icon: Icon(Icons.clear),
                          )
                        : null,
                  ),
                ),
                if (con.searchEnabled && con.searchController.text != "")
                  Positioned(
                    top: 60, // Adjust the position of the suggestion list as needed
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 200, // Set the height of the suggestion list as needed
                      decoration: BoxDecoration(
                        color: cs.surface,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                      child: ListView.builder(
                        itemCount: 4, // Replace with the actual number of suggestions
                        itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              title: Text(
                                "a product",
                                style: tt.titleMedium!.copyWith(color: cs.onSurface),
                              ),
                              leading: Image.network(
                                  "https://static.vecteezy.com/system/resources/previews/000/223/713/original/vector-realistic-dentist-tools-and-tooth-healthcare-equipment-set.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
