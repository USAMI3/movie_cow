import 'package:flutter/material.dart';
import 'package:movie_cow/core/app/colors.dart';

/// Class for any app-wide utility functions that are re-useable
class AppUtils {
  AppUtils._();

  /// Displays a Snackbar with custom message
  static Future<void> showSnackbar(
    State widgetState,
    String msg, {
    Function()? onClosed,
  }) async {
    final SnackBar snackBar = SnackBar(
      content: Text(
        msg,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'OK',
        textColor: AppColors.exampleColor,
        onPressed: () {
          if (widgetState.mounted) {
            if (onClosed == null) {
              ScaffoldMessenger.of(widgetState.context).hideCurrentSnackBar();
            } else {
              ScaffoldMessenger.of(widgetState.context).hideCurrentSnackBar();
              onClosed();
            }
          }
        },
      ),
    );
    if (widgetState.mounted) {
      if (onClosed == null) {
        ScaffoldMessenger.of(widgetState.context).showSnackBar(snackBar);
      } else {
        ScaffoldMessenger.of(widgetState.context)
            .showSnackBar(snackBar)
            .closed
            .then(
          (SnackBarClosedReason reason) {
            if (reason != SnackBarClosedReason.action) {
              onClosed();
            }
          },
        );
      }
    }
  }
}
