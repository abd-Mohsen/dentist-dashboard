import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SelectionField<T> extends StatelessWidget {
  const SelectionField({
    super.key,
    required this.title,
    required this.iconData,
    this.hint,
    required this.items,
    required this.onSelect,
    this.itemAsString,
    required this.label,
    this.tileBuilder,
  });

  final String title;
  final String label;
  final String? hint;
  final IconData iconData;
  final List<T> items;
  final void Function(T?) onSelect;
  final String Function(T)? itemAsString;
  final Widget Function(BuildContext, T?)? tileBuilder;

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(" $title ", style: tt.titleLarge!.copyWith(color: cs.onSurface)),
          DropdownSearch<T>(
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  fillColor: Colors.white70,
                  hintText: "search".tr,
                  prefix: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(Icons.search, color: cs.onSurface),
                  ),
                ),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: label,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12, left: 8),
                  child: Icon(iconData, size: 30),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              baseStyle: tt.bodyLarge!.copyWith(color: cs.onSurface),
            ),
            items: items,
            itemAsString: itemAsString,
            onChanged: onSelect,
            dropdownBuilder: tileBuilder,
          ),
        ],
      ),
    );
  }
}
