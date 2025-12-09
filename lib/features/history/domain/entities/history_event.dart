import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_event.freezed.dart';
part 'history_event.g.dart';

@freezed
abstract class HistoryEvent with _$HistoryEvent {
  const factory HistoryEvent({
    required DateTime date,
    required String level, // 'Normal', 'Drowsy'
    required double ear,
  }) = _HistoryEvent;

  factory HistoryEvent.fromJson(Map<String, dynamic> json) =>
      _$HistoryEventFromJson(json);
}
