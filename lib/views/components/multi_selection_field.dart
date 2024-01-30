import 'package:flutter/material.dart';

class MultiSelectionField<T> extends StatelessWidget {
  const MultiSelectionField({
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border(
                  //
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
