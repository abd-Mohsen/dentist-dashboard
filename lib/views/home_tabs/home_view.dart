import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:dentist_dashboard/views/components/info_card.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    int getGrid() {
      if (ResponsiveWidget.isSmall(context))
        return 1;
      else if (ResponsiveWidget.isMed(context))
        return 2;
      else
        return 4;
    }

    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: getGrid()),
              children: [
                InfoCard(),
                InfoCard(),
                InfoCard(),
                InfoCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
