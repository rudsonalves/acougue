import 'dart:developer';

class Logger {
  final String source;

  Logger(this.source);

  static const magenta = '\x1B[35m';
  static const red = '\x1B[31m';
  static const blue = '\x1B[94m';
  static const yellow = '\x1B[33m';
  static const green = '\x1B[32m';
  static const normal = '\x1B[0m';

  void info(String module, dynamic err) {
    log(_mountMessage(green, '$source.$module: $err'));
  }

  void debug(String module, dynamic err) {
    log(_mountMessage(blue, '$source.$module: $err'));
  }

  void warning(String module, dynamic err) {
    log(_mountMessage(yellow, '$source.$module: $err'));
  }

  void critical(String module, dynamic err) {
    log(_mountMessage(magenta, '$source.$module: $err'));
  }

  String _mountMessage(String color, String message) {
    return '$color$message$normal';
  }
}
