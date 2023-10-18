import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final Widget chart;
  final String title;
  final String subTitle;
  final Widget? legends;
  const ChartContainer({
    super.key,
    required this.chart,
    required this.title,
    required this.subTitle,
    this.legends,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: tt.titleMedium!.copyWith(color: cs.onBackground),
          ),
          Text(
            subTitle,
            style: tt.bodySmall!.copyWith(color: cs.onBackground.withOpacity(0.8)),
          ),
          chart,
          legends ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
