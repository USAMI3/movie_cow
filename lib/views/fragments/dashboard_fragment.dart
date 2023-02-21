import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_cow/core/app/colors.dart';
import 'package:movie_cow/core/app/texts.dart';

class DashboardFragment extends ConsumerStatefulWidget {
  const DashboardFragment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardFragmentState();
}

class _DashboardFragmentState extends ConsumerState<DashboardFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'This area is under development!',
              style: TextStyle(
                color: AppColors.lightPurpleColor,
                fontFamily: AppTexts.boldAppFont,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please head over to Watch section',
              style: TextStyle(
                color: AppColors.yellowColor,
                fontFamily: AppTexts.boldAppFont,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '==>',
              style: TextStyle(
                color: AppColors.pinkColor,
                fontFamily: AppTexts.boldAppFont,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
