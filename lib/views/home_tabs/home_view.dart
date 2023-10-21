import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:dentist_dashboard/views/components/bar_chart.dart';
import 'package:dentist_dashboard/views/components/chart_container.dart';
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

    usersPieChart() => ChartContainer(
          chart: PieChartSample(),
          title: "users roles",
          subTitle: "for more details about users check 'manage users' tab.",
          legends: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 7,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "admins",
                      style: tt.labelLarge!.copyWith(color: cs.onSurface),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 7,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "dentists",
                      style: tt.labelLarge!.copyWith(color: cs.onSurface),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.brown,
                      radius: 7,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "suppliers",
                      style: tt.labelLarge!.copyWith(color: cs.onSurface),
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    barChart() => ChartContainer(
          chart: BarChartSample(),
          title: "users roles",
          subTitle: "for more details about users check '"
              "manage users' tab.",
          legends: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 7,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "admins",
                      style: tt.labelLarge!.copyWith(color: cs.onSurface),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 7,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "dentists",
                      style: tt.labelLarge!.copyWith(color: cs.onSurface),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.brown,
                      radius: 7,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "suppliers",
                      style: tt.labelLarge!.copyWith(color: cs.onSurface),
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: ResponsiveWidget.isSmall(context)
            ? [
                ...cards,
                barChart(),
                usersPieChart(),
              ]
            : [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ResponsiveWidget.isMed(context) ? med() : large(),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 60,
                      child: barChart(),
                    ),
                    Expanded(
                      flex: 40,
                      child: usersPieChart(),
                    ),
                  ],
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
      ),
    );
  }
}
