import 'package:intl/intl.dart';

class CurrencyUtils {
  CurrencyUtils._();

  static final NumberFormat _tryFormat = NumberFormat.currency(
    locale: 'tr_TR',
    symbol: '₺',
    decimalDigits: 2,
  );

  static final NumberFormat _numberFormat = NumberFormat.decimalPattern('tr_TR');

  static String formatTRY(double amount) => _tryFormat.format(amount);

  static String formatNumber(double number, {int decimalDigits = 0}) {
    final formatter = NumberFormat.decimalPattern('tr_TR')
      ..minimumFractionDigits = decimalDigits
      ..maximumFractionDigits = decimalDigits;
    return formatter.format(number);
  }

  static String formatQuantity(double quantity) {
    if (quantity == quantity.roundToDouble()) {
      return quantity.toInt().toString();
    }
    return _numberFormat.format(quantity);
  }
}
