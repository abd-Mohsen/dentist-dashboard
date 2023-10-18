import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample extends StatefulWidget {
  const PieChartSample({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSampleState();
}

class PieChartSampleState extends State {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 350,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      3,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 20.0 : 16.0;
        final radius = isTouched ? 110.0 : 100.0;
        final widgetSize = isTouched ? 65.0 : 50.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.redAccent,
              value: 10,
              title: '10%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
                shadows: shadows,
              ),
              badgeWidget: _Badge(
                'https://th.bing.com/th?id=OIP.bbXsNwMXrGKMvEjwoz6j2QHaHa&w=250&h=250&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
                size: widgetSize,
                borderColor: Colors.black,
              ),
              badgePositionPercentageOffset: .98,
            );
          case 1:
            return PieChartSectionData(
              color: Colors.grey,
              value: 30,
              title: '30%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
                shadows: shadows,
              ),
              badgeWidget: _Badge(
                'https://th.bing.com/th?id=OIP.5hhCZnPZytQed785bV_SdgHaHa&w=250&h=250&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
                size: widgetSize,
                borderColor: Colors.black,
              ),
              badgePositionPercentageOffset: .98,
            );
          case 2:
            return PieChartSectionData(
              color: Colors.purple,
              value: 60,
              title: '60%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
                shadows: shadows,
              ),
              badgeWidget: _Badge(
                'https://th.bing.com/th?id=OIP.Txke-24ySmldyyKA_aUkWQAAAA&w=250&h=250&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
                size: widgetSize,
                borderColor: Colors.black,
              ),
              badgePositionPercentageOffset: .98,
            );
          default:
            throw Exception('Oh no');
        }
      },
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(child: Image.network(svgAsset)),
    );
  }
}
