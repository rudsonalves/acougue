import 'package:flutter/material.dart';

import '/ui/core/themes/dimens.dart';
import '/ui/core/themes/fonts.dart';

class AppSnackBar {
  static void showBottom(
    BuildContext context, {
    String? title,
    IconData? iconTitle,
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
    VoidCallback? onClosed,
  }) {
    final scaffoldMessager = ScaffoldMessenger.of(context);

    // Remove any existing Snackbar
    scaffoldMessager.clearSnackBars();

    // Create the SnackBar
    final snackBar = _createSnackBar(
      context,
      title: title,
      iconTitle: iconTitle,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );

    final scaffoldController = scaffoldMessager.showSnackBar(snackBar);

    scaffoldController.closed.then((_) {
      if (onClosed != null) onClosed();
    });

    return;
  }

  static SnackBar _createSnackBar(
    BuildContext context, {
    String? title,
    IconData? iconTitle,
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final radius = Dimens.of(context).radius;
    final textStyle = AppFontsStyle.of(context);

    return SnackBar(
      duration: duration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      elevation: 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: colorScheme.onPrimaryContainer,
      margin: EdgeInsets.symmetric(
        horizontal: Dimens.of(context).paddingScreenHorizontal,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconTitle != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(iconTitle, color: colorScheme.onPrimary),
                  ),
                Text(title, style: textStyle.displayTextStyle),
              ],
            ),
          if (title != null) Divider(),
          Text(message, style: textStyle.bodyTextStyle),
        ],
      ),
      action:
          (actionLabel != null && onActionPressed != null)
              ? SnackBarAction(
                label: actionLabel,
                onPressed: onActionPressed,
                textColor: colorScheme.onPrimary,
              )
              : null,
    );
  }
}
