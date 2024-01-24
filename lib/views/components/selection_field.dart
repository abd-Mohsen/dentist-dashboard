import 'package:dentist_dashboard/views/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SelectionField<T> extends StatelessWidget {
  const SelectionField({
    super.key,
    required this.title,
    required this.iconData,
    this.hint,
    required this.onTap,
    required this.items,
  });

  final String title;
  final String? hint;
  final IconData iconData;
  final List<T> items;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(" $title ", style: tt.titleLarge!.copyWith(color: cs.onSurface)),
          Row(
            children: [
              DropdownSearch<T>(
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                ),
                items: items,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Menu mode",
                    hintText: "country in menu mode",
                  ),
                ),
              ),
              CustomButton(
                onTap: onTap,
                color: cs.primary,
                title: "add".tr,
                textColor: cs.onPrimary,
              )
            ],
          ),
        ],
      ),
    );
  }
}
