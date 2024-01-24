import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onTap;
  final Color color;
  final String title;
  final IconData? iconData;
  final Color? iconColor;
  final Color textColor;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.title,
    this.iconData,
    this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Row(
              children: [
                Text(title, style: tt.titleMedium!.copyWith(color: textColor)),
                const SizedBox(width: 8),
                if (iconData != null) Icon(iconData, color: iconColor ?? Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
