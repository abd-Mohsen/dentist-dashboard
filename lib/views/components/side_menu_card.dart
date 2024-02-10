import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:flutter/material.dart';

class SideMenuCard extends StatefulWidget {
  final void Function() onTap;
  final String title;
  final IconData icon;
  final bool isSelected;

  const SideMenuCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.isSelected,
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
    return InkWell(
      onTap: widget.onTap,
      onHover: (bool val) {
        setState(() {
          isHovered = val;
        });
      },
      mouseCursor: MaterialStateMouseCursor.clickable,
      child: SizedBox(
        height: ResponsiveWidget.isLarge(context) ? 55 : 90,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            color: isHovered ? Colors.grey[200]!.withOpacity(0.3) : null,
            child: ResponsiveWidget.isLarge(context)
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: widget.isSelected,
                          child: Container(
                            color: Colors.red,
                            width: 4,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          widget.icon,
                          size: 25,
                          color: cs.onPrimary.withOpacity(0.8),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          widget.title,
                          style: tt.titleMedium!.copyWith(
                            color: cs.onPrimary,
                            fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                : Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: widget.isSelected,
                        child: Container(
                          color: Colors.red,
                          width: 4,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 16),
                            Icon(
                              widget.icon,
                              size: 25,
                              color: cs.onPrimary.withOpacity(0.8),
                            ),
                            //const SizedBox(width: 8),
                            Text(
                              widget.title,
                              style: tt.titleMedium!.copyWith(
                                color: cs.onPrimary,
                                fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
