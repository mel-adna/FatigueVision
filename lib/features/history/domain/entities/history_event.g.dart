// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryEvent _$HistoryEventFromJson(Map<String, dynamic> json) =>
    _HistoryEvent(
      date: DateTime.parse(json['date'] as String),
      level: json['level'] as String,
      ear: (json['ear'] as num).toDouble(),
    );

Map<String, dynamic> _$HistoryEventToJson(_HistoryEvent instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'level': instance.level,
      'ear': instance.ear,
    };
