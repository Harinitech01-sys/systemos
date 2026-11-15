import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppErrorHandler {
  AppErrorHandler._();

  static void initialize() {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      logError(
        details.exceptionAsString(),
        details.stack ?? StackTrace.current,
        context: details.context?.toDescription(),
      );
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      logError(error.toString(), stack, context: 'platform_dispatcher');
      return true;
    };

    ErrorWidget.builder = (details) {
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 18,
                    color: Color(0x1A000000),
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 36,
                      color: Color(0xFFB42318),
                    ),
                    SizedBox(height: 16),
                    Text('Something went wrong', textAlign: TextAlign.center),
                    SizedBox(height: 8),
                    Text(
                      'Please restart HariniOS.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    };
  }

  static void logError(
    String message,
    StackTrace stackTrace, {
    String? context,
  }) {
    final labeledContext = context == null ? 'HariniOS' : 'HariniOS: $context';
    debugPrint('$labeledContext\n$message\n$stackTrace');
  }
}
