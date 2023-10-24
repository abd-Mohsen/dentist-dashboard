import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:flutter/material.dart';

class SideMenuCard extends StatefulWidget {
  final void Function() onTap;
  final Text title;
  final Widget icon;
  final bool isSelected;

  const SideMenuCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.isSelected,
  });

  @override
  _SideMenuCardState createState() => _SideMenuCardState();
}

class _SideMenuCardState extends State<SideMenuCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsiveWidget.isLarge(context)
          ? const EdgeInsets.symmetric(vertical: 4)
          : const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: ResponsiveWidget.isLarge(context) ? 50 : 65,
        child: InkWell(
          onTap: widget.onTap,
          onHover: (bool val) {
            setState(() {
              isHovered = val;
            });
          },
          mouseCursor: MaterialStateMouseCursor.clickable,
          // child: ListTile(
          //   title: widget.title,
          //   leading: widget.icon,
          //   tileColor: isHovered ? Colors.grey[200]!.withOpacity(0.3) : null,
          // ),
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
                        widget.icon,
                        const SizedBox(width: 20),
                        widget.title,
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
                            widget.icon,
                            //const SizedBox(width: 8),
                            widget.title,
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
