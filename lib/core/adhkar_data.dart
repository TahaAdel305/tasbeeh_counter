import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Zikr {
  final int id;
  final String text;
  final int count;

  const Zikr({required this.id, required this.text, required this.count});

  factory Zikr.fromJson(Map<String, dynamic> json) {
    return Zikr(
      id: json['id'] as int,
      text: json['text'] as String,
      count: json['count'] as int,
    );
  }
}

class ZikrCategory {
  final int id;
  final String name;
  final List<Zikr> azkar;

  const ZikrCategory({
    required this.id,
    required this.name,
    required this.azkar,
  });

  factory ZikrCategory.fromJson(Map<String, dynamic> json) {
    return ZikrCategory(
      id: json['id'] as int,
      name: json['category'] as String,
      azkar: (json['array'] as List)
          .map((e) => Zikr.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

Future<List<ZikrCategory>> loadAdhkar() async {
  final raw = await rootBundle.loadString('assets/data/adhkar.json');
  final list = jsonDecode(raw) as List;
  return list
      .map((e) => ZikrCategory.fromJson(e as Map<String, dynamic>))
      .toList();
}