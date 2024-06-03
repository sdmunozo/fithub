import 'dart:ui';

class GlobalConfigProvider {
  static double? maxHeight;
  static double? maxWidth;
  static Color color4 = const Color(0xFF268FBE);

  static void setMaxHeight(double height) {
    maxHeight = height;
  }

  static double? getMaxHeight() {
    return maxHeight;
  }

  static void setMaxWidth(double width) {
    maxWidth = width;
  }

  static double? getMaxWidth() {
    return maxWidth;
  }
}
