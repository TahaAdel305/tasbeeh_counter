import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasbeeh_counter/core/Service/stats_service.dart';
import '../../screen_widget/statistics_screen.dart';

class StatsService extends ChangeNotifier {
  final Map<String, Map<String, int>> _data = {};
  static const _storageKey = 'tasbeeh_stats';
  late SharedPreferences _prefs;

  String _dayKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> addTasbeeh(String zikr) async {
    final day = _data.putIfAbsent(_dayKey(DateTime.now()), () => {});
    day[zikr] = (day[zikr] ?? 0) + 1;
    notifyListeners();
    await _prefs.setString(_storageKey, jsonEncode(_data));
    //debugPrint(_data.toString());
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs.getString(_storageKey);
    if (raw == null) return;

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    decoded.forEach((day, azkar) {
      _data[day] = (azkar as Map<String, dynamic>).map(
        (zikr, count) => MapEntry(zikr, count as int),
      );
    });
  }

  int totalForDay(DateTime d) {
    final day = _data[_dayKey(d)];
    if (day == null) return 0;
    return day.values.fold<int>(0, (sum, count) => sum + count);
  }

  int get today => totalForDay(DateTime.now());

  List<int> get weekTotals {
    final now = DateTime.now();
    final offset = (now.weekday + 1) % 7; // السبت = 0 ... الجمعة = 6
    return List.generate(7, (i) {
      return totalForDay(DateTime(now.year, now.month, now.day - offset + i));
    });
  }

  int get weekTotal => weekTotals.fold<int>(0, (sum, c) => sum + c);

  int get monthTotal {
    final now = DateTime.now();
    var sum = 0;
    for (var d = 1; d <= now.day; d++) {
      sum += totalForDay(DateTime(now.year, now.month, d));
    }
    return sum;
  }

  int get allTotal {
    var sum = 0;
    for (final day in _data.values) {
      sum += day.values.fold<int>(0, (s, c) => s + c);
    }
    return sum;
  }

  List<String> _keysFor(StatsRange range) {
    final now = DateTime.now();
    switch (range) {
      case StatsRange.day:
        return [_dayKey(now)];
      case StatsRange.week:
        final offset = (now.weekday + 1) % 7;
        return List.generate(
          7,
          (i) => _dayKey(DateTime(now.year, now.month, now.day - offset + i)),
        );
      case StatsRange.month:
        return List.generate(
          now.day,
          (i) => _dayKey(DateTime(now.year, now.month, i + 1)),
        );
      case StatsRange.all:
        return _data.keys.toList();
    }
  }

  List<MapEntry<String, int>> topAzkar(StatsRange range) {
    final totals = <String, int>{};
    for (final key in _keysFor(range)) {
      final day = _data[key];
      if (day == null) continue;
      day.forEach((zikr, count) {
        totals[zikr] = (totals[zikr] ?? 0) + count;
      });
    }
    final sorted = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted;
  }
}
