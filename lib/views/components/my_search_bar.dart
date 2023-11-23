import 'package:dentist_dashboard/controllers/brand_controller.dart';
import 'package:dentist_dashboard/views/brands/brand_view.dart';
import 'package:dentist_dashboard/views/components/search_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../products/product_view.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    required this.textEditingController,
    required this.focusNode,
    required this.scrollController,
    required this.onTapField,
    required this.onTapClear,
    required this.onTapOutsideField,
    required this.onQueryChange,
    required this.searchResult,
    required this.suggestionsVisible,
    required this.hint,
    required this.type,
  });

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final ScrollController scrollController;
  final void Function() onTapField;
  final void Function() onTapClear;
  final void Function(PointerDownEvent) onTapOutsideField;
  final void Function(String) onQueryChange;
  final List searchResult;
  final bool suggestionsVisible;
  final String hint;
  final String type;

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    void Function() onClickCard(obj) {
      if (type == "product") {
        return () {
          Get.put(ProductController());
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => ProductView(product: obj),
          );
        };
      }
      if (type == "brand") {
        return () {
          Get.put(BrandController(brand: obj));
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => BrandView(brand: obj),
          );
        };
      }
      return () {
        print("not a product or a category or a brand?");
      };
    }

    String correctImagePath(obj) {
      if (type == "product") {
        return obj.images[0].path;
      }
      if (type == "brand" || type == "category") {
        return obj.image;
      }
      return "wtf";
    }

    return Column(
      children: [
        TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onTap: onTapField,
          onTapOutside: onTapOutsideField,
          onChanged: onQueryChange,
          style: tt.labelLarge!.copyWith(color: cs.onBackground),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: suggestionsVisible
                  ? const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                  : BorderRadius.circular(20),
            ),
            hintText: hint,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: suggestionsVisible
                ? IconButton(
                    onPressed: onTapClear,
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
        ),
        Visibility(
          visible: suggestionsVisible,
          child: Material(
            elevation: 5,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            child: Container(
              height: 150, // Set the height of the suggestion list as needed
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              ),
              child: Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                interactive: true,
                child: searchResult.isEmpty
                    ? const Center(child: Text("no result"))
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: searchResult.length,
                        itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SearchCard(
                            title: searchResult[i].title,
                            imagePath: correctImagePath(searchResult[i]),
                            onTap: onClickCard(searchResult[i]),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
