import 'package:flutter/cupertino.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  double get topPadding => MediaQuery.of(this).viewPadding.top;
  double get rightPadding => MediaQuery.of(this).viewPadding.right;
  double get leftPadding => MediaQuery.of(this).viewPadding.left;
  double get bottomPadding => MediaQuery.of(this).viewPadding.bottom;

  double get top => MediaQuery.of(this).viewInsets.top;
  double get right => MediaQuery.of(this).viewInsets.right;
  double get left => MediaQuery.of(this).viewInsets.left;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
}
