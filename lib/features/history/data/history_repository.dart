import 'dart:convert';
import 'package:fatigue_vision/features/history/domain/entities/history_event.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class HistoryRepository {
  static const _key = 'history_events';
  final SharedPreferences _prefs;

  HistoryRepository(this._prefs);

  @factoryMethod
  static Future<HistoryRepository> init() async {
    final prefs = await SharedPreferences.getInstance();
    return HistoryRepository(prefs);
  }

  Future<void> saveEvent(HistoryEvent event) async {
    final events = await getEvents();
    events.insert(0, event); // Add to top
    final jsonList = events.map((e) => e.toJson()).toList();
    await _prefs.setString(_key, jsonEncode(jsonList));
  }

  Future<List<HistoryEvent>> getEvents() async {
    final jsonString = _prefs.getString(_key);
    if (jsonString == null) return [];

    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList
        .map((e) => HistoryEvent.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> clearHistory() async {
    await _prefs.remove(_key);
  }
}
