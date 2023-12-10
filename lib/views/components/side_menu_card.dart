import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:flutter/material.dart';

class SideMenuCard extends StatefulWidget {
  final void Function() onTap;
  final String title;
  final IconData icon;
  final bool isSelected;
  final bool isTop; // is this card above the selected card
  final bool isBottom; // is this card below the selected card

  const SideMenuCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.isTop,
    required this.isBottom,
  });

  @override
  State<SideMenuCard> createState() => _SideMenuCardState();
}

class _SideMenuCardState extends State<SideMenuCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    TextDirection td = Directionality.of(context);

    icon() => Icon(
          widget.icon,
          size: widget.isSelected ? 30 : 25,
          color: widget.isSelected ? cs.primary : cs.onPrimary.withOpacity(0.8),
        );

    text() => Text(
          widget.title,
          style: tt.titleMedium!.copyWith(
            color: widget.isSelected ? cs.primary : cs.onPrimary,
            fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );

    return InkWell(
      enableFeedback: false,
      onTap: widget.onTap,
      onHover: (bool val) {
        setState(() {
          isHovered = val;
        });
      },
      mouseCursor: MaterialStateMouseCursor.clickable,
      child: Container(
        height: ResponsiveWidget.isLarge(context) ? 60 : 90,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? cs.background
              : isHovered
                  ? cs.primary.withOpacity(0.8)
                  : cs.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: widget.isTop && td == TextDirection.rtl ? const Radius.circular(20) : Radius.zero,
            topLeft: widget.isBottom && td == TextDirection.rtl ? const Radius.circular(20) : Radius.zero,
            bottomRight: widget.isTop && td == TextDirection.ltr ? const Radius.circular(20) : Radius.zero,
            topRight: widget.isBottom && td == TextDirection.ltr ? const Radius.circular(20) : Radius.zero,
          ),
        ),
        child: ResponsiveWidget.isLarge(context)
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 12),
                    icon(),
                    const SizedBox(width: 20),
                    text(),
                  ],
                ),
              )
            : Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 16),
                        icon(),
                        text(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
