import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:dentist_dashboard/views/components/info_card.dart';
import 'package:dentist_dashboard/views/components/pie_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    int getGrid() {
      if (ResponsiveWidget.isSmall(context))
        return 1;
      else if (ResponsiveWidget.isMed(context))
        return 2;
      else
        return 4;
    }

    List<Widget> cards = [
      InfoCard(
        cardColor: Colors.orangeAccent,
        title: "new users",
        value: "69",
        cardIcon: Icons.person_2_outlined,
      ),
      InfoCard(
        cardColor: Colors.redAccent,
        title: "orders this month",
        value: "69",
        cardIcon: Icons.library_books_outlined,
      ),
      InfoCard(
        cardColor: Colors.lightGreenAccent,
        title: "new products",
        value: "69",
        cardIcon: Icons.shopping_bag_outlined,
      ),
      InfoCard(
        cardColor: Colors.deepPurpleAccent,
        title: "emails sent",
        value: "69",
        cardIcon: Icons.email_outlined,
      ),
    ];
    large() => cards.map((card) => Expanded(child: card)).toList();

    med() => [
          Expanded(
            child: Column(
              children: [cards[0], cards[1]],
            ),
          ),
          Expanded(
            child: Column(
              children: [cards[2], cards[3]],
            ),
          ),
        ];

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ResponsiveWidget.isMed(context) ? med() : large(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: cs.surface,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "users roles" + ":",
                        style: tt.headlineSmall!.copyWith(color: cs.onBackground),
                      ),
                    ),
                    PieChartSample(),
                  ],
                ),
              ),
            ],
          ),
        )
        // PieChart(
        //   PieChartData(
        //     sectionsSpace: 10,
        //     startDegreeOffset: 2,
        //     sections: [
        //       PieChartSectionData(
        //         value: 50,
        //         color: Colors.red,
        //         showTitle: true,
        //         title: "admin",
        //         titleStyle: tt.labelLarge,
        //       ),
        //       PieChartSectionData(
        //         value: 50,
        //         color: Colors.red,
        //         showTitle: true,
        //         title: "admin",
        //         titleStyle: tt.labelLarge,
        //       ),
        //     ],
        //   ),
        //   swapAnimationDuration: Duration(milliseconds: 150), // Optional
        //   swapAnimationCurve: Curves.linear, // Optional
        // ),
      ],
    );
  }
}
