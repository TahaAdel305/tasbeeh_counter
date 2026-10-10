import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasbeeh_counter/core/Service/stats_service.dart';
import 'package:tasbeeh_counter/core/theme/app_color.dart';

import '../../screen_widget/statistics_screen.dart';

class RangeTabs extends StatelessWidget {
  final StatsRange selected;
  final ValueChanged<StatsRange> onChanged;

  const RangeTabs({super.key, required this.selected, required this.onChanged});

  static const labels = {
    StatsRange.day: "اليوم",
    StatsRange.week: "الأسبوع",
    StatsRange.month: "الشهر",
    StatsRange.all: "الكل",
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: StatsRange.values.map((r) {
        final isSelected = r == selected;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => onChanged(r),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFF1E9E0)
                      : const Color(0xFF1F5A4A),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  labels[r]!,
                  style: TextStyle(
                    color: isSelected ? appcolor.colordark : appcolor.colorlight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}