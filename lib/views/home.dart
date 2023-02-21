// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_cow/core/app/colors.dart';
import 'package:movie_cow/core/app/svg.dart';
import 'package:movie_cow/core/app/texts.dart';
import 'package:movie_cow/views/fragments/dashboard_fragment.dart';
import 'package:movie_cow/views/fragments/media_library_fragment.dart';
import 'package:movie_cow/views/fragments/more_fragment.dart';
import 'package:movie_cow/views/fragments/watch_fragment.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  List<Widget> fragmentList = [
    const DashboardFragment(),
    const WatchFragment(),
    const MediaLibraryFragment(),
    const MoreFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: fragmentList[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(27), topRight: Radius.circular(27)),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.whiteColor,
          unselectedItemColor: AppColors.greyColor,
          selectedLabelStyle: const TextStyle(
            fontFamily: AppTexts.appFont,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: AppTexts.appFont,
          ),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  AppSvg.dashboardSvg,
                  colorFilter: currentIndex == 0
                      ? const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        )
                      : null,
                ),
              ),
              label: AppTexts.bottomBarText0,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  AppSvg.watchSvg,
                  colorFilter: currentIndex == 1
                      ? const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        )
                      : null,
                ),
              ),
              label: AppTexts.bottomBarText1,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  AppSvg.mediaLibrarySvg,
                  colorFilter: currentIndex == 2
                      ? const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        )
                      : null,
                ),
              ),
              label: AppTexts.bottomBarText2,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                  AppSvg.moreSvg,
                  colorFilter: currentIndex == 3
                      ? const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        )
                      : null,
                ),
              ),
              label: AppTexts.bottomBarText3,
            ),
          ],
          backgroundColor: AppColors.purpleColor,
          onTap: (int index) {
            currentIndex = index;
            setState(() {});
          },
        ),
      ),
    );
  }
}
