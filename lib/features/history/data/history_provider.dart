import 'package:fatigue_vision/config/injection.dart';
import 'package:fatigue_vision/features/history/data/history_repository.dart';
import 'package:fatigue_vision/features/history/domain/entities/history_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyProvider = FutureProvider<List<HistoryEvent>>((ref) async {
  final repo = getIt<HistoryRepository>();
  return repo.getEvents();
});
