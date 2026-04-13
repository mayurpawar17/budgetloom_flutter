import 'package:intl/intl.dart';

class AppDateUtil {
  // Added a more comprehensive default pattern
  static String formatString(
    String dateStr, {
    String pattern = 'MMMM d, yyyy – h:mm a',
  }) {
    if (dateStr.isEmpty) return "";

    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat(pattern).format(dateTime);
    } catch (e) {
      return "Invalid Date";
    }
  }
}
