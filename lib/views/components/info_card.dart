import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Color cardColor;
  final String title;
  final String value;
  final IconData cardIcon;
  const InfoCard({
    super.key,
    required this.cardColor,
    required this.title,
    required this.value,
    required this.cardIcon,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    final isRTL = Directionality.of(context) == TextDirection.rtl;
    final begin = isRTL ? Alignment.topRight : Alignment.topLeft;
    final end = isRTL ? Alignment.bottomLeft : Alignment.bottomRight;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cardColor, cs.surface],
          begin: begin,
          end: end,
          stops: [0.5, 1],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8.0, bottom: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: tt.titleMedium!.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: tt.headlineSmall!.copyWith(color: cs.onSurface),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(cardIcon, size: 50),
          ),
        ],
      ),
    );
  }
}
