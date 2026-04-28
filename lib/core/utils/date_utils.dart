import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static final DateFormat _dayMonthYear = DateFormat('dd MMMM yyyy', 'tr_TR');
  static final DateFormat _shortDate = DateFormat('dd.MM.yyyy', 'tr_TR');
  static final DateFormat _monthYear = DateFormat('MMMM yyyy', 'tr_TR');
  static final DateFormat _dayMonth = DateFormat('dd MMMM', 'tr_TR');

  static String formatDayMonthYear(DateTime date) => _dayMonthYear.format(date);
  static String formatShortDate(DateTime date) => _shortDate.format(date);
  static String formatMonthYear(DateTime date) => _monthYear.format(date);
  static String formatDayMonth(DateTime date) => _dayMonth.format(date);

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  static bool isWithinDays(DateTime date, int days) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final diff = target.difference(today).inDays;
    return diff >= 0 && diff <= days;
  }

  static int daysUntil(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    return target.difference(today).inDays;
  }

  static String relativeDateText(DateTime date) {
    final days = daysUntil(date);
    if (days == 0) return 'Bugün';
    if (days == 1) return 'Yarın';
    if (days < 0) return '${-days} gün önce';
    return '$days gün sonra';
  }
}
