import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'app_logger.dart';

@LazySingleton(as: AppLogger)
final class LoggerAppLogger implements AppLogger {
  LoggerAppLogger(this._logger);

  final Logger _logger;

  @override
  void debug(String message) => _logger.d(message);

  @override
  void info(String message) => _logger.i(message);

  @override
  void warning(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
