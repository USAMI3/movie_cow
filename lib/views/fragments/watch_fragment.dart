// ignore_for_file: always_specify_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_cow/core/app/colors.dart';
import 'package:movie_cow/core/app/styles.dart';
import 'package:movie_cow/core/app/texts.dart';
import 'package:movie_cow/core/providers/movie_provider.dart';
import 'package:movie_cow/core/services/api/api_services.dart';
import 'package:movie_cow/core/services/api/models/movie_model.dart';
import 'package:movie_cow/core/services/api/models/search_movie_model.dart';
import 'package:movie_cow/views/sub_fragments/movie_detail.dart';
import 'package:movie_cow/views/sub_fragments/searched_movie_detail.dart';
import 'package:movie_cow/views/widgets/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../core/providers/search_provider.dart';

class WatchFragment extends ConsumerStatefulWidget {
  const WatchFragment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WatchFragmentState();
}

class _WatchFragmentState extends ConsumerState<WatchFragment> {
  final ApiRequests apiRequests = ApiRequests();
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        appBar: ref.watch(movieProvider).isSearching == true
            ? AppBar(
                backgroundColor: AppColors.whiteColor,
                elevation: 0,
                title: TextField(
                  controller: _searchController,
                  autofocus: true,
                  onChanged: (String value) async {
                    bool isNetwork = await isNetworkAvailable();

                    if (isNetwork == true) {
                      ref.read(searchmovieProvider).query = value;
                    } else {
                      toast('Please connect to the internet to access Search');
                    }
                  },
                  onSubmitted: (String value) async {
                    bool isNetwork = await isNetworkAvailable();
                    print(isNetwork);
                    if (isNetwork == true) {
                      ref.read(searchmovieProvider).searchedPrompt();
                      ref.read(movieProvider).searchPrompt();
                    } else {
                      toast('Please connect to the internet to access Search');
                    }
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: AppTexts.watchSearchHintText,
                    hintStyle: TextStyle(
                      color: AppColors.greyColor,
                    ),
                    border: InputBorder.none,
                  ),
                  cursorColor: AppColors.purpleColor,
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      ref.read(movieProvider).searchPrompt();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              )
            : ref.watch(searchmovieProvider).haveSearched == true
                ? AppBar(
                    backgroundColor: AppColors.whiteColor,
                    elevation: 0,
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              ref.read(searchmovieProvider).searchedPrompt();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.blueGreyColor,
                            ),
                          ),
                          Text(
                            '${ref.watch(searchmovieProvider).movies.length} Results Found',
                            style: AppStyles.watchAppBarTextstyle,
                          ),
                        ],
                      ),
                    ),
                  )
                : AppBar(
                    backgroundColor: AppColors.whiteColor,
                    elevation: 0,
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppTexts.watchAppBarTitle,
                        style: AppStyles.watchAppBarTextstyle,
                      ),
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
                          ref.read(movieProvider).searchPrompt();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
        body: ref.watch(movieProvider).isSearching == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (ref.watch(searchmovieProvider).movies.isEmpty) ...[
                    const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                          color: AppColors.purpleColor,
                          fontFamily: AppTexts.boldAppFont,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ] else ...[
                    Flexible(
                      fit: FlexFit.loose,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: ref.read(searchmovieProvider).movies.length,
                        itemBuilder: (BuildContext context, int index) {
                          final SearchResult movie =
                              ref.watch(searchmovieProvider).movies[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              index == 0
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.03,
                                        top: size.height * 0.02,
                                        bottom: size.height * 0.01,
                                      ),
                                      child: const Text(
                                        'Top Results',
                                        style: TextStyle(
                                          color: AppColors.blueGreyColor,
                                          fontFamily: AppTexts.appFont,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  SearchedMovieDetail(movie).launch(context);
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height:
                                            orientation == Orientation.portrait
                                                ? size.height * 0.12
                                                : size.height * 0.3,
                                        width:
                                            orientation == Orientation.portrait
                                                ? size.width * 0.35
                                                : size.width * 0.25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              'https://image.tmdb.org/t/p/original${movie.backdropPath}',
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.4,
                                      child: Text(
                                        movie.title,
                                        style: AppStyles.searchedBodyTextstyle,
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.04),
                                      child: const Icon(
                                        Icons.more_horiz,
                                        color: AppColors.cyanColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ],
              )
            : ref.watch(searchmovieProvider).haveSearched == true
                ? Column(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              ref.read(searchmovieProvider).movies.length,
                          itemBuilder: (BuildContext context, int index) {
                            final SearchResult movie =
                                ref.watch(searchmovieProvider).movies[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    SearchedMovieDetail(movie).launch(context);
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: orientation ==
                                                  Orientation.portrait
                                              ? size.height * 0.12
                                              : size.height * 0.3,
                                          width: orientation ==
                                                  Orientation.portrait
                                              ? size.width * 0.35
                                              : size.width * 0.25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                'https://image.tmdb.org/t/p/original${movie.backdropPath}',
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.4,
                                        child: Text(
                                          movie.title,
                                          style:
                                              AppStyles.searchedBodyTextstyle,
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: size.width * 0.04),
                                        child: const Icon(
                                          Icons.more_horiz,
                                          color: AppColors.cyanColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder<MovieModel>(
                        future: apiRequests.getUpcomingMovies(),
                        builder: (BuildContext context,
                            AsyncSnapshot<MovieModel> snapshot) {
                          if (snapshot.hasData) {
                            final MovieModel? data = snapshot.data;
                            return Flexible(
                              fit: FlexFit.loose,
                              child: CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                slivers: [
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return Column(
                                          children: <Widget>[
                                            index == 0
                                                ? SizedBox(
                                                    height: size.height * 0.04,
                                                  )
                                                : const SizedBox(),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.05),
                                              child: InkWell(
                                                onTap: () {
                                                  MovieDetail(
                                                          data.results[index])
                                                      .launch(context);
                                                },
                                                child: Container(
                                                  width: orientation ==
                                                          Orientation.portrait
                                                      ? size.width
                                                      : size.width * 0.7,
                                                  height: orientation ==
                                                          Orientation.portrait
                                                      ? size.height * 0.25
                                                      : size.height * 0.5,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.purpleColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image:
                                                          CachedNetworkImageProvider(
                                                        'https://image.tmdb.org/t/p/original${data.results[index].backdropPath}',
                                                        cacheManager:
                                                            DefaultCacheManager(),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Positioned.fill(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            gradient:
                                                                LinearGradient(
                                                              begin: Alignment
                                                                  .bottomCenter,
                                                              end: Alignment
                                                                  .topCenter,
                                                              colors: [
                                                                Colors.black
                                                                    .withOpacity(
                                                                        0.7),
                                                                Colors
                                                                    .transparent,
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Text(
                                                              data
                                                                  .results[
                                                                      index]
                                                                  .title,
                                                              style: AppStyles
                                                                  .watchMovieNameTextstyle,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.02,
                                            ),
                                          ],
                                        );
                                      },
                                      childCount: data!.results.length,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const Center(child: LoaderWidget());
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
