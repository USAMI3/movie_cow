// ignore_for_file: always_specify_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_cow/core/app/colors.dart';
import 'package:movie_cow/core/app/styles.dart';
import 'package:movie_cow/core/app/texts.dart';
import 'package:movie_cow/core/services/api/api_services.dart';
import 'package:movie_cow/core/services/api/models/search_movie_model.dart';
import 'package:movie_cow/views/widgets/loading_widget.dart';
import 'package:movie_cow/views/widgets/video_player.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../core/providers/movie_provider.dart';

class SearchedMovieDetail extends ConsumerStatefulWidget {
  final SearchResult result;
  const SearchedMovieDetail(this.result, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchedMovieDetailState();
}

class _SearchedMovieDetailState extends ConsumerState<SearchedMovieDetail> {
  final ApiRequests apiRequests = ApiRequests();

  final List<Color> genreColorsList = <Color>[
    AppColors.cyanColor,
    AppColors.pinkColor,
    AppColors.lightPurpleColor,
    AppColors.yellowColor,
    AppColors.lightColor,
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: orientation == Orientation.portrait
          ? Scaffold(
              body: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: size.height * 0.52,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.purpleColor,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(
                            'https://image.tmdb.org/t/p/original${widget.result.posterPath}',
                            cacheManager: DefaultCacheManager(),
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.7),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'In Theatres ${ref.read(movieProvider).formatDate(widget.result.releaseDate.toString())}',
                                  style: AppStyles.movieDetailTheatreTextstyle,
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: size.width * 0.6,
                                    height: size.height * 0.07,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Text(
                                      AppTexts.movieDetailTickets,
                                      style:
                                          AppStyles.movieDetailTicketsTextstyle,
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                InkWell(
                                  onTap: () async {
                                    bool isNetwork = await isNetworkAvailable();

                                    if (isNetwork == true) {
                                      VideoPlayerScreen(
                                        movieId: widget.result.id,
                                      ).launch(context);
                                    } else {
                                      toast(
                                          'Please connect to the internet first');
                                    }
                                  },
                                  child: Container(
                                    width: size.width * 0.6,
                                    height: size.height * 0.07,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.lightColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.play_arrow,
                                          color: AppColors.whiteColor,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.01,
                                        ),
                                        Text(
                                          AppTexts.movieDetailwatchTrailer,
                                          style: AppStyles
                                              .movieDetailTrailerTextstyle,
                                        ),
                                      ],
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.05,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            finish(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          AppTexts.watchAppBarTitle,
                          style: AppStyles.watchAppBarTextstyleWhite,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.45,
                            left: size.width * 0.06,
                          ),
                          child: Text(
                            AppTexts.movieDetailGenres,
                            style: AppStyles.movieDetailGenreTextstyle,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.06,
                            ),
                            child: SizedBox(
                              height: size.height * 0.05,
                              child: FutureBuilder<Map<int, String>>(
                                future: apiRequests.fetchGenres(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Map<int, String>> snapshot) {
                                  if (snapshot.hasData) {
                                    final Map<int, String>? data =
                                        snapshot.data;
                                    final List<String?> genreNames = widget
                                        .result.genreIds
                                        .map((int id) => data![id])
                                        .toList();
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: widget.result.genreIds.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Row(
                                          children: [
                                            index != 0
                                                ? SizedBox(
                                                    width: size.width * 0.02,
                                                  )
                                                : const SizedBox(),
                                            Container(
                                              height: size.width * 0.08,
                                              decoration: BoxDecoration(
                                                color: genreColorsList[index],
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    genreNames[index]!,
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.whiteColor,
                                                      fontFamily:
                                                          AppTexts.boldAppFont,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  return const Center(
                                    child: LoaderWidget(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.06,
                          ),
                          child: Text(
                            AppTexts.movieDetailOverview,
                            style:
                                AppStyles.movieDetailOverviewHeadingTextstyle,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.06,
                          ),
                          child: Text(
                            widget.result.overview,
                            style: AppStyles.movieDetailOverviewTextstyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Scaffold(
              body: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: size.height * 0.927,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          color: AppColors.purpleColor,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                              'https://image.tmdb.org/t/p/original${widget.result.posterPath}',
                              cacheManager: DefaultCacheManager(),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    finish(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  AppTexts.watchAppBarTitle,
                                  style: AppStyles.watchAppBarTextstyleWhite,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              'In Theatres ${ref.read(movieProvider).formatDate(widget.result.releaseDate.toString())}',
                              style: AppStyles.movieDetailTheatreTextstyle,
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: size.width * 0.23,
                                    height: size.height * 0.13,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Text(
                                      AppTexts.movieDetailTickets,
                                      style:
                                          AppStyles.movieDetailTicketsTextstyle,
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                InkWell(
                                  onTap: () async {
                                    bool isNetwork = await isNetworkAvailable();

                                    if (isNetwork == true) {
                                      VideoPlayerScreen(
                                        movieId: widget.result.id,
                                      ).launch(context);
                                    } else {
                                      toast(
                                          'Please connect to the internet first');
                                    }
                                  },
                                  child: Container(
                                    width: size.width * 0.23,
                                    height: size.height * 0.13,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.lightColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.play_arrow,
                                          color: AppColors.whiteColor,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.01,
                                        ),
                                        Text(
                                          AppTexts.movieDetailwatchTrailer,
                                          style: AppStyles
                                              .movieDetailTrailerTextstyle,
                                        ),
                                      ],
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.03,
                        ),
                        child: Text(
                          AppTexts.movieDetailGenres,
                          style: AppStyles.movieDetailGenreTextstyle,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.03,
                          ),
                          child: SizedBox(
                            height: size.height * 0.08,
                            width: size.width * 0.45,
                            child: FutureBuilder<Map<int, String>>(
                              future: apiRequests.fetchGenres(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<Map<int, String>> snapshot) {
                                if (snapshot.hasData) {
                                  final Map<int, String>? data = snapshot.data;
                                  final List<String?> genreNames = widget
                                      .result.genreIds
                                      .map((int id) => data![id])
                                      .toList();
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: widget.result.genreIds.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        children: [
                                          index != 0
                                              ? SizedBox(
                                                  width: size.width * 0.02,
                                                )
                                              : const SizedBox(),
                                          Container(
                                            height: size.height * 0.15,
                                            decoration: BoxDecoration(
                                              color: genreColorsList[index],
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  genreNames[index]!,
                                                  style: const TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontFamily:
                                                        AppTexts.boldAppFont,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                return const Center(
                                  child: LoaderWidget(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.03,
                        ),
                        child: Text(
                          AppTexts.movieDetailOverview,
                          style: AppStyles.movieDetailOverviewHeadingTextstyle,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.03,
                        ),
                        child: SizedBox(
                          width: size.width * 0.4,
                          child: Text(
                            widget.result.overview,
                            style: AppStyles.movieDetailOverviewTextstyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
