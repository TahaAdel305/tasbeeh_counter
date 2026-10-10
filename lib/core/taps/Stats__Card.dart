import 'package:flutter/material.dart';

import '../theme/app_color.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final Widget child;
  const StatsCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? const [Color(0xFF2F6B58), Color(0xFF123F33)]
              : const [Color(0xffe8ddd1), Color(0xffe6caa9)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:  TextStyle(
                color: isDark?appcolor.textDark:appcolor.textLight,
                  fontSize: 15, fontWeight
                  : FontWeight.w700)),
           SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}