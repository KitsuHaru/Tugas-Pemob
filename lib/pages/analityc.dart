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
      value: 40, // Percentage for Work
      title: 'Work',
      color: Colors.blue,
      radius: 60,
    ),
    PieChartSectionData(
      value: 35, // Percentage for Study
      title: 'Study',
      color: Colors.green,
      radius: 60,
    ),
    PieChartSectionData(
      value: 25, // Percentage for Exercise
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
        title: Text('Activity Breakdown', style: TextStyle(color: Colors.white)),
         backgroundColor: Colors.teal,
         leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Ikon panah kembali
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Center(
        child: PieChart(
          PieChartData(
            sections: pieChartData.map((data) {
              final isTouched = pieChartData.indexOf(data) == touchedIndex;
              final opacity = isTouched ? 1.0 : 0.6;
              final percentage = (data.value / totalValue * 100).toStringAsFixed(1); // Calculate percentage
              return PieChartSectionData(
                value: data.value,
                title: isTouched ? '${data.title}\n$percentage%' : data.title, // Show percentage when touched
                // ignore: deprecated_member_use
                color: data.color.withOpacity(opacity),
                radius: isTouched ? 70 : 60,
                titleStyle: TextStyle(
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
                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
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