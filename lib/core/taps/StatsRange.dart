import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasbeeh_counter/core/Service/stats_service.dart';

import '../theme/app_color.dart';


class TotalCard extends StatelessWidget {
  final int total;
  const TotalCard({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final gradientColors = isDark
        ? const [Color(0xFF2F6B58), Color(0xFF123F33)]
        : const [Color(0xffe8ddd1), Color(0xffe6caa9)];
    final mainText = isDark ? Colors.white : const Color(0xFF123F33);
    final subText = isDark ? Colors.white70 : Colors.black54;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors/*[Color(0xFF2F6B58), Color(0xFF123F33)]*/,
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.bar_chart_rounded, color: isDark?appcolor.textDark:appcolor.textLight, size: 28),
          const SizedBox(height: 8),
          Text("إجمالي التسبيحات",
              style: TextStyle(color: isDark?appcolor.textDark:appcolor.textLight, fontSize: 14)),
          const SizedBox(height: 4),
          Text("$total",
              style: TextStyle(
                  color: isDark?appcolor.textDark:appcolor.textLight, fontSize: 52, fontWeight: FontWeight.w800)),
          Text("تسبيحة",
              style: TextStyle(color: isDark?appcolor.textDark:appcolor.textLight, fontSize: 14)),
        ],
      ),
    );
  }
}