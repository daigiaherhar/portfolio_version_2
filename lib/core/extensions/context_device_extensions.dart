import 'package:flutter/material.dart';

extension ContextDeviceExtensions on BuildContext {
  /// Logical width of the display (viewport), excluding system UI where
  /// [MediaQuery] already applies padding.
  double get deviceWidth => MediaQuery.sizeOf(this).width;

  /// Logical height of the display (viewport).
  double get deviceHeight => MediaQuery.sizeOf(this).height;

  Size get deviceSize => MediaQuery.sizeOf(this);

  EdgeInsets get devicePadding => MediaQuery.paddingOf(this);
}
