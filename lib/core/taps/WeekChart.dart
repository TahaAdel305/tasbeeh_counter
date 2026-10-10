import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tasbeeh_counter/core/theme/app_color.dart';

class WeekChart extends StatelessWidget {
  final List<int> values;
  const WeekChart({super.key, required this.values});

  static const days = [
    'السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final labelColor = isDark ? appcolor.colorlight:appcolor.colordark;//Colors.red : Colors.black54;
    final gridColor = isDark ? Colors.white12 : Colors.black12;

    final maxVal = values.reduce((a, b) => a > b ? a : b);
    final interval =
    (((maxVal / 3) / 50).ceil() * 50).clamp(50, 1000000).toDouble();
    final maxY = interval * ((maxVal / interval).ceil()).clamp(3, 1000000);

    return SizedBox(
      height: 200,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: BarChart(
          BarChartData(
            minY: 0,
            maxY: maxY,
            alignment: BarChartAlignment.spaceAround,
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              drawVerticalLine: false,
              horizontalInterval: interval,
              getDrawingHorizontalLine: (_) =>
                  FlLine(color: gridColor, strokeWidth: 1),
            ),
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 34,
                  interval: interval,
                  getTitlesWidget: (value, meta) => Text(
                    '${value.toInt()}',
                    style: TextStyle(fontSize: 10, color: labelColor),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final i = value.toInt();
                    if (i < 0 || i > 6) return const SizedBox();
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(days[i],
                          style: TextStyle(fontSize: 9, color: labelColor)),
                    );
                  },
                ),
              ),
            ),
            barGroups: List.generate(
              7,
                  (i) => BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: values[i].toDouble(),
                    width: 18,
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(6)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDark
                          ?const [Color(0xFF3E7D68), Color(0xFF1B4D3E)]
                          :const [Color(0xd5dcb585), Color(0xff937151)],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}