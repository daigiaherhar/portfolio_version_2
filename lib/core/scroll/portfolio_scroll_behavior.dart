import 'dart:ui';

import 'package:flutter/material.dart';

/// Lets [PageView] and other scrollables respond to mouse / trackpad drags
/// (default Material behavior is often touch-only on some platforms).
class PortfolioScrollBehavior extends MaterialScrollBehavior {
  const PortfolioScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}
