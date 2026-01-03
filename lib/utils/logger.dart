// lib/utils/logger.dart

import 'package:flutter/foundation.dart';

/// Simple logging utility for the app
/// Only logs in debug mode, suppressed in release builds
class AppLogger {
  static const String _prefix = '[BahayKusina]';

  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('$_prefix [INFO] $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }

  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('$_prefix [WARN] $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('$_prefix [ERROR] $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }

  static void debug(String message) {
    if (kDebugMode) {
      debugPrint('$_prefix [DEBUG] $message');
    }
  }
}
