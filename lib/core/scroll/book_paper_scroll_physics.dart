import 'package:flutter/material.dart';

/// When the paper has no vertical overflow, do not claim drag gestures so the
/// parent [PageView] can receive horizontal swipes.
class BookPaperScrollPhysics extends ClampingScrollPhysics {
  const BookPaperScrollPhysics({super.parent});

  @override
  BookPaperScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BookPaperScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    if (position.maxScrollExtent <= 0) {
      return false;
    }
    return super.shouldAcceptUserOffset(position);
  }
}
