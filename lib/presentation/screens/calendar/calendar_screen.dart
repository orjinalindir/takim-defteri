import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entities/wedding.dart';
import '../../providers/app_providers.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final selectedDate = _selectedDay ?? _focusedDay;
    final weddingsAsync = ref.watch(
      weddingsByMonthProvider((year: _focusedDay.year, month: _focusedDay.month)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.calendar),
      ),
      body: ListView(
        children: [
          // Calendar
          weddingsAsync.when(
            data: (weddings) => _buildCalendar(weddings),
            loading: () => _buildCalendar([]),
            error: (_, _) => _buildCalendar([]),
          ),

          const Divider(),

          // Selected day weddings
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Text(
              AppStrings.weddingsOnDay,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          weddingsAsync.when(
            data: (weddings) {
              final dayWeddings = weddings.where((w) => isSameDay(w.weddingDate, selectedDate)).toList();

              if (dayWeddings.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingL),
                  child: Center(
                    child: Text(
                      AppStrings.noWeddingsOnDay,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                );
              }

              if (dayWeddings.length > 1) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                      padding: const EdgeInsets.all(AppSizes.paddingS),
                      decoration: BoxDecoration(
                        color: AppColors.errorRed.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppSizes.radiusS),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning, color: AppColors.errorRed),
                          const SizedBox(width: AppSizes.paddingS),
                          Text(
                            AppStrings.conflictWarning,
                            style: const TextStyle(
                              color: AppColors.errorRed,
                              fontWeight: FontWeight.w600,
                              fontSize: AppSizes.fontM,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...dayWeddings.map(_buildWeddingTile),
                  ],
                );
              }

              return Column(
                children: dayWeddings.map(_buildWeddingTile).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const SizedBox.shrink(),
          ),

          const Divider(),

          // Season analysis
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Text(
              AppStrings.seasonAnalysis,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          weddingsAsync.when(
            data: (weddings) => _buildSeasonChart(weddings),
            loading: () => const SizedBox(height: 200),
            error: (_, _) => const SizedBox.shrink(),
          ),

          const SizedBox(height: AppSizes.paddingXL),
        ],
      ),
    );
  }

  Widget _buildCalendar(List<Wedding> weddings) {
    return TableCalendar(
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      locale: 'tr_TR',
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onFormatChanged: (format) {
        setState(() => _calendarFormat = format);
      },
      onPageChanged: (focusedDay) {
        setState(() => _focusedDay = focusedDay);
        ref.invalidate(
          weddingsByMonthProvider((year: focusedDay.year, month: focusedDay.month)),
        );
      },
      eventLoader: (day) {
        return weddings.where((w) => isSameDay(w.weddingDate, day)).toList();
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isEmpty) return null;
          final hasConflict = events.length > 1;
          return Positioned(
            bottom: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: hasConflict ? AppColors.errorRed : AppColors.primaryGold,
                    shape: BoxShape.circle,
                  ),
                ),
                if (hasConflict) ...[
                  const SizedBox(width: 2),
                  const Icon(Icons.warning, size: 10, color: AppColors.errorRed),
                ],
              ],
            ),
          );
        },
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: AppColors.primaryGoldLight,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryGold, width: 2),
        ),
        todayTextStyle: const TextStyle(
          color: AppColors.secondaryNavy,
          fontWeight: FontWeight.w700,
        ),
        selectedDecoration: const BoxDecoration(
          color: AppColors.primaryGold,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        defaultTextStyle: const TextStyle(fontSize: AppSizes.fontM),
        weekendTextStyle: const TextStyle(
          fontSize: AppSizes.fontM,
          color: AppColors.textSecondary,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: AppSizes.fontL,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildWeddingTile(Wedding wedding) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingXS,
      ),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryGoldLight,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          child: const Icon(Icons.celebration, color: AppColors.primaryGold),
        ),
        title: Text(
          wedding.title,
          style: const TextStyle(
            fontSize: AppSizes.fontL,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${wedding.brideName} & ${wedding.groomName}${wedding.venue != null ? ' • ${wedding.venue}' : ''}',
          style: const TextStyle(fontSize: AppSizes.fontM),
        ),
      ),
    );
  }

  Widget _buildSeasonChart(List<Wedding> weddings) {
    final monthlyCounts = List.filled(12, 0);
    for (final wedding in weddings) {
      monthlyCounts[wedding.weddingDate.month - 1]++;
    }

    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: (monthlyCounts.reduce((a, b) => a > b ? a : b) + 2).toDouble(),
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const months = ['O', 'Ş', 'M', 'N', 'M', 'H', 'T', 'A', 'E', 'E', 'K', 'A'];
                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        months[value.toInt()],
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            barGroups: List.generate(12, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: monthlyCounts[index].toDouble(),
                    color: AppColors.primaryGold,
                    width: 16,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
