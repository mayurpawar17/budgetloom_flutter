import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(printer: SimplePrinter());

  static Logger get instance => _logger;
}
