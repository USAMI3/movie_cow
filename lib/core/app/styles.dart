import 'package:flutter/material.dart';
import 'package:movie_cow/core/app/colors.dart';

/// All styles used for widgets go here
class AppStyles {
  AppStyles._();

  /// example-textstyle
  static TextStyle exampleTextstyle = const TextStyle(
    color: AppColors.exampleColor,
    fontWeight: FontWeight.w300,
    fontSize: 16.0,
  );

  /// example-textstyle-2
  static TextStyle exampleTextstyle2 = TextStyle(
    color: AppColors.exampleColorSwatch.shade400,
    fontWeight: FontWeight.w300,
    fontSize: 20.0,
  );
}
