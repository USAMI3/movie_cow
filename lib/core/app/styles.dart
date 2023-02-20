import 'package:flutter/material.dart';
import 'package:movie_cow/core/app/colors.dart';
import 'package:movie_cow/core/app/texts.dart';

/// All styles used for widgets go here
class AppStyles {
  AppStyles._();

  /// watch-appBar-textstyle
  static TextStyle watchAppBarTextstyle = const TextStyle(
    color: AppColors.blueGreyColor,
    fontWeight: FontWeight.bold,
    fontFamily: AppTexts.appFont,
    fontSize: 16.0,
  );
  static TextStyle watchAppBarTextstyleWhite = const TextStyle(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
    fontFamily: AppTexts.appFont,
    fontSize: 16.0,
  );
  static TextStyle watchMovieNameTextstyle = const TextStyle(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
    fontFamily: AppTexts.appFont,
    fontSize: 18.0,
  );

  //movie-detail-styles
  static TextStyle movieDetailTheatreTextstyle = const TextStyle(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
    fontFamily: AppTexts.appFont,
    fontSize: 16.0,
  );
  static TextStyle movieDetailTicketsTextstyle = const TextStyle(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
    fontFamily: AppTexts.appFont,
    fontSize: 14.0,
  );
  static TextStyle movieDetailTrailerTextstyle = const TextStyle(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
    fontFamily: AppTexts.appFont,
    fontSize: 14.0,
  );
}
