import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final List<PieChartSectionData> sections;

  const PieChartWidget({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust size as needed
      child: PieChart(
        PieChartData(
          sections: sections,
          centerSpaceRadius: 40,
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
        ),
      ),
    );
  }
}
