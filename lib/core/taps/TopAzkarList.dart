import 'package:flutter/material.dart';
import 'package:tasbeeh_counter/core/theme/app_color.dart';

class TopAzkarList extends StatelessWidget {
  final List<MapEntry<String, int>> items;
  const TopAzkarList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8),
        child: Text("لسه ما سبّحتش في الفترة دي"),
      );
    }

    final maxCount = items.first.value;

    return Column(
      children: items.map((e) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SizedBox(
                width: 120,
                child: Text(e.key,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: e.value / maxCount,
                    minHeight: 6,
                    color: isDark ?Color(0xd5dcb585): Color(0xFF12372D) ,
                    backgroundColor:
                    isDark ? Colors.white12 : Colors.black12,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text("${e.value}"),
            ],
          ),
        );
      }).toList(),
    );
  }
}