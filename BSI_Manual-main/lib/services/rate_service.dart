\
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class RateItem {
  final String code;
  final String name;
  final String unit;
  final double amount;
  final String category;

  RateItem({required this.code, required this.name, required this.unit, required this.amount, required this.category});

  factory RateItem.fromJson(Map<String, dynamic> j) => RateItem(
    code: j['code'] ?? '',
    name: j['name'] ?? '',
    unit: j['unit'] ?? '',
    amount: (j['amount'] ?? 0).toDouble(),
    category: j['category'] ?? 'General',
  );
}

class RateService {
  final List<RateItem> items;
  RateService(this.items);

  static Future<RateService> loadFromAssets(String path) async {
    final txt = await rootBundle.loadString(path);
    final data = (json.decode(txt) as List).map((e) => RateItem.fromJson(e)).toList();
    return RateService(data);
  }

  List<RateItem> search(String query) {
    final q = query.toLowerCase();
    return items.where((i) => i.name.toLowerCase().contains(q) || i.code.toLowerCase().contains(q) || i.category.toLowerCase().contains(q)).toList();
  }

  List<String> categories() => items.map((e) => e.category).toSet().toList()..sort();
}
