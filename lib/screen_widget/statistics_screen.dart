import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasbeeh_counter/core/Service/stats_service.dart';
import '../core/taps/Range_Tabs.dart';
import '../core/taps/StatsRange.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tasbeeh_counter/core/theme/app_color.dart';

import '../core/taps/Stats__Card.dart';
import '../core/taps/TopAzkarList.dart';
import '../core/taps/WeekChart.dart';


enum StatsRange { day, week, month, all }

class statistics_screen extends StatefulWidget {
  const statistics_screen({super.key});

  @override
  State<statistics_screen> createState() => _statistics_screenState();
}

class _statistics_screenState extends State<statistics_screen> {
  StatsRange range = StatsRange.day;

  @override
  Widget build(BuildContext context) {

     var width = MediaQuery.of(context).size.width;
     var hight = MediaQuery.of(context).size.height;
     final isDark = Theme.of(context).brightness == Brightness.dark;

    final stats = context.watch<StatsService>();

    final total = switch (range) {
      StatsRange.day => stats.today,
      StatsRange.week => stats.weekTotal,
      StatsRange.month => stats.monthTotal,
      StatsRange.all => stats.allTotal,
    };

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: hight*0.01,),
               Text(
                "الإحصائيات",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                    color: isDark?appcolor.textDark:appcolor.textLight),
              ),
              SizedBox(height: hight*0.02,),
              RangeTabs(
                selected: range,
                onChanged: (r) => setState(() => range = r),
              ),
              SizedBox(height: hight*0.02,),

              TotalCard(total: total),
               SizedBox(height: 16),

              StatsCard(
                title: "تقدم الأسبوع",
                child: WeekChart(values: stats.weekTotals),
              ),
              const SizedBox(height: 16),

              StatsCard(
                title: "أكثر الأذكار استخداماً",
                child: TopAzkarList(items: stats.topAzkar(range)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}