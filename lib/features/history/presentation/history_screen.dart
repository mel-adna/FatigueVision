import 'package:fatigue_vision/features/history/data/history_provider.dart';
import 'package:fatigue_vision/features/history/domain/entities/history_event.dart';
import 'package:fatigue_vision/l10n/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.dashboard),
        actions: [
          historyAsync.when(
            data: (data) => IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: data.isEmpty
                  ? null
                  : () => _generatePdf(context, data),
            ),
            error: (_, _) => const SizedBox(),
            loading: () => const SizedBox(),
          ),
        ],
      ),
      body: historyAsync.when(
        data: (results) {
          if (results.isEmpty) {
            return Center(child: Text(context.l10n.noDataAvailable));
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
                      context.l10n.alertsToday,
                      todayEvents.toString(),
                      Icons.today,
                      Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      context.l10n.totalEvents,
                      results.length.toString(),
                      Icons.history,
                      Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // CHART SECTION
              Text(
                context.l10n.weeklyActivity,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 240,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: _buildWeeklyChart(context, results),
              ),

              const SizedBox(height: 24),
              Text(
                context.l10n.recentActivity,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 12),
              // List Items
              ...results.take(10).map((item) {
                // Limit to last 10 items for better performance
                final isDrowsy = item.level == 'Drowsy';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
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
                        item.level == 'Drowsy'
                            ? context.l10n.drowsy
                            : item.level == 'Normal'
                            ? context.l10n.normal
                            : item.level,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat('yyyy-MM-dd HH:mm').format(item.date),
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.7),
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

  Widget _buildWeeklyChart(BuildContext context, List<HistoryEvent> events) {
    // 1. Bucketing last 7 days
    final now = DateTime.now();
    final dayCounts = <int, int>{};
    for (var i = 0; i < 7; i++) {
      dayCounts[i] = 0; // Initialize 0-6 (Mon-Sun or relative days)
    }

    // We want the last 7 days relative to Today (index 6) going back to Today-6 (index 0)
    // Actually, simpler: Let's make bars for Day - 6 to Day - 0 (Today)

    for (final event in events) {
      final diff = now.difference(event.date).inDays;
      if (diff >= 0 && diff < 7) {
        // diff 0 = today => index 6
        // diff 6 = a week ago => index 0
        final index = 6 - diff;
        dayCounts[index] = (dayCounts[index] ?? 0) + 1;
      }
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY:
            (dayCounts.values.isNotEmpty
                    ? dayCounts.values.reduce((a, b) => a > b ? a : b) + 1
                    : 1)
                .toDouble(),
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Colors.transparent,
            tooltipPadding: EdgeInsets.zero,
            tooltipMargin: 8,
            getTooltipItem:
                (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.toY.round().toString(),
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final index = value.toInt();
                // 6 = Today, 5 = Yesterday...
                final date = now.subtract(Duration(days: 6 - index));
                final dayName = DateFormat(
                  'E',
                ).format(date).substring(0, 1); // M, T, W...
                return SideTitleWidget(
                  meta: meta,
                  space: 4,
                  child: Text(
                    dayName,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(7, (index) {
          final count = dayCounts[index] ?? 0;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: count.toDouble(),
                color: Theme.of(context).colorScheme.primary,
                width: 16,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY:
                      (dayCounts.values.isNotEmpty
                              ? dayCounts.values.reduce(
                                      (a, b) => a > b ? a : b,
                                    ) +
                                    2
                              : 2)
                          .toDouble(), // slightly higher max
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ],
            showingTooltipIndicators: count > 0 ? [0] : [],
          );
        }),
      ),
    );
  }

  Future<void> _generatePdf(
    BuildContext context,
    List<HistoryEvent> results,
  ) async {
    final pdf = pw.Document();
    final l10n = context.l10n;

    pdf.addPage(
      pw.Page(
        build: (pw.Context pwContext) {
          return pw.Column(
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(
                  l10n.reportTitle,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                context: pwContext,
                data: <List<String>>[
                  <String>[
                    l10n.date,
                    l10n.time,
                    l10n.level,
                    l10n.ear,
                  ],
                  ...results.map((item) {
                    return [
                      DateFormat('yyyy-MM-dd').format(item.date),
                      DateFormat('HH:mm').format(item.date),
                      if (item.level == 'Drowsy')
                        l10n.drowsy
                      else if (item.level == 'Normal')
                        l10n.normal
                      else
                        item.level,
                      item.ear.toStringAsFixed(2),
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
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
