import 'package:intl/intl.dart';

class AppFormatter {
  /// Formats 18300.0 to ₹ 18,300.0
  static String formatCurrency(double amount, {String symbol = '₹'}) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN', // Use 'en_IN' for Indian comma system or 'en_US'
      symbol: '$symbol ',
      decimalDigits: 1, // Ensures .0 stays visible
    );
    return formatter.format(amount);
  }
}
