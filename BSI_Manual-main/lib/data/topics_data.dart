import '../models/topic_model.dart';

const _raw = [];

List<Topic> get topics => _raw.map<Topic>((e) => Topic(
  id: e['id'] ?? 0,
  title: e['title'] ?? '',
  buttons: (e['buttons'] as List).map((x) => x.toString()).toList(),
)).toList();
