import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/theme/const_colors.dart';
import 'package:portfolio_version_2/core/theme/const_sizes.dart';

/// Scrollable paper body with black-on-paper text theme.
class BookPaperScroll extends StatelessWidget {
  final Widget child;

  const BookPaperScroll({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: ConstColors.black,
          displayColor: ConstColors.black,
        ),
      ),
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.fromLTRB(
          ConstSizes.s20,
          ConstSizes.s22,
          ConstSizes.s20,
          ConstSizes.s28,
        ),
        child: child,
      ),
    );
  }
}
