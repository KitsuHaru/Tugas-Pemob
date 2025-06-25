import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalitycPage extends StatefulWidget {
  const AnalitycPage({super.key});

  @override
  State<AnalitycPage> createState() => _AnalitycPageState();
}

class _AnalitycPageState extends State<AnalitycPage> {
  final List<PieChartSectionData> pieChartData = [
    PieChartSectionData(
      value: 40,
      title: 'Work',
      color: Colors.blue,
      radius: 60,
    ),
    PieChartSectionData(
      value: 35,
      title: 'Study',
      color: Colors.green,
      radius: 60,
    ),
    PieChartSectionData(
      value: 25,
      title: 'Exercise',
      color: Colors.orange,
      radius: 60,
    ),
  ];

  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    double totalValue = pieChartData.fold(0, (sum, item) => sum + item.value);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Breakdown',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: PieChart(
          PieChartData(
            sections: pieChartData.map((data) {
              final isTouched = pieChartData.indexOf(data) == touchedIndex;
              final opacity = isTouched ? 1.0 : 0.6;
              final percentage =
                  (data.value / totalValue * 100).toStringAsFixed(1);
              return PieChartSectionData(
                value: data.value,
                title: isTouched ? '${data.title}\n$percentage%' : data.title,
                color: data.color.withOpacity(opacity),
                radius: isTouched ? 70 : 60,
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }).toList(),
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (pieTouchResponse != null &&
                      pieTouchResponse.touchedSection is! FlPointerExitEvent &&
                      pieTouchResponse.touchedSection is! PointerUpEvent) {
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  } else {
                    touchedIndex = null;
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
