import 'package:flutter/material.dart';

/// Drives slow organic motion for [CustomPainter]s under the book reader.
class BookMotionInherited extends InheritedNotifier<Animation<double>> {
  const BookMotionInherited({
    super.key,
    required Animation<double> notifier,
    required super.child,
  }) : super(notifier: notifier);

  static Animation<double>? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BookMotionInherited>()
        ?.notifier;
  }
}
