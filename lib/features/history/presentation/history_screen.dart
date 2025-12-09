import 'package:fatigue_vision/features/history/domain/entities/history_event.dart';
import 'package:fatigue_vision/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import 'package:fatigue_vision/features/history/data/history_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.history),
        actions: [
          historyAsync.when(
            data: (data) => IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: data.isEmpty
                  ? null
                  : () => _generatePdf(context, data),
            ),
            error: (_, __) => const SizedBox(),
            loading: () => const SizedBox(),
          ),
        ],
      ),
      body: historyAsync.when(
        data: (results) {
          if (results.isEmpty) {
            return Center(child: Text(context.l10n.history));
          }

          // Calculate stats
          final today = DateTime.now();
          final todayEvents = results
              .where(
                (e) =>
                    e.date.year == today.year &&
                    e.date.month == today.month &&
                    e.date.day == today.day,
              )
              .length;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Dashboard header
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Alerts Today',
                      todayEvents.toString(),
                      Icons.today,
                      Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Total Events',
                      results.length.toString(),
                      Icons.history,
                      Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 12),
              // List Items
              ...results.map((item) {
                final isDrowsy = item.level == 'Drowsy';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).cardTheme.color ??
                          Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Icon(
                        isDrowsy ? Icons.warning_amber : Icons.check_circle,
                        color: isDrowsy ? Colors.redAccent : Colors.greenAccent,
                      ),
                      title: Text(
                        item.level,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat('yyyy-MM-dd HH:mm').format(item.date),
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      trailing: Text(
                        'EAR: ${item.ear.toStringAsFixed(2)}',
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
        error: (err, stack) => Center(child: Text('Error: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> _generatePdf(
    BuildContext context,
    List<HistoryEvent> results,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(
                  'FatigueVision Report',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Date', 'Time', 'Level', 'EAR'],
                  ...results.map((item) {
                    return [
                      DateFormat('yyyy-MM-dd').format(item.date),
                      DateFormat('HH:mm').format(item.date),
                      item.level,
                      (item.ear).toStringAsFixed(2),
                    ];
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
