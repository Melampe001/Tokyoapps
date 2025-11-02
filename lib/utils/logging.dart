import 'package:flutter/foundation.dart';

/// Centralized logging utility
/// In production, this should be replaced with Firebase Crashlytics or similar
class AppLogger {
  static void log(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] $message');
    }
  }
  
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
      if (error != null) debugPrint('Error: $error');
      if (stackTrace != null) debugPrint('Stack trace: $stackTrace');
    }
    // In production, send to Firebase Crashlytics:
    // FirebaseCrashlytics.instance.recordError(error, stackTrace, reason: message);
  }
  
  static void warning(String message) {
    if (kDebugMode) {
      debugPrint('[WARNING] $message');
    }
  }
}
