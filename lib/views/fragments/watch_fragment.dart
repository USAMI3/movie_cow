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
import 'package:movie_cow/views/sub_fragments/movie_detail.dart';
import 'package:movie_cow/views/widgets/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class WatchFragment extends ConsumerStatefulWidget {
  const WatchFragment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WatchFragmentState();
}

class _WatchFragmentState extends ConsumerState<WatchFragment> {
  final ApiRequests apiRequests = ApiRequests();
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
                  decoration: InputDecoration(
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<MovieModel>(
              future: apiRequests.getUpcomingMovies(),
              builder:
                  (BuildContext context, AsyncSnapshot<MovieModel> snapshot) {
                if (snapshot.hasData) {
                  final MovieModel? data = snapshot.data;
                  return Flexible(
                    fit: FlexFit.loose,
                    child: CustomScrollView(
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
                                        horizontal: size.width * 0.05),
                                    child: InkWell(
                                      onTap: () {
                                        MovieDetail(data.results[index])
                                            .launch(context);
                                      },
                                      child: Container(
                                        width:
                                            orientation == Orientation.portrait
                                                ? size.width
                                                : size.width * 0.7,
                                        height:
                                            orientation == Orientation.portrait
                                                ? size.height * 0.25
                                                : size.height * 0.5,
                                        decoration: BoxDecoration(
                                          color: AppColors.purpleColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: CachedNetworkImageProvider(
                                              'https://image.tmdb.org/t/p/original${data.results[index].posterPath}',
                                              cacheManager:
                                                  DefaultCacheManager(),
                                            ),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.black
                                                          .withOpacity(0.7),
                                                      Colors.transparent,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Text(
                                                    data.results[index].title,
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

                    // ListView.builder(
                    //   itemCount: data!.results.length,
                    //   shrinkWrap: true,
                    //   physics: const BouncingScrollPhysics(),
                    //   scrollDirection: Axis.vertical,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return
                    //     Column(
                    //       children: <Widget>[
                    //         index == 0
                    //             ? SizedBox(
                    //                 height: size.height * 0.04,
                    //               )
                    //             : const SizedBox(),
                    //         Padding(
                    //           padding: EdgeInsets.symmetric(
                    //               horizontal: size.width * 0.05),
                    //           child: Container(
                    //             width: orientation == Orientation.portrait
                    //                 ? size.width
                    //                 : size.width * 0.7,
                    //             height: orientation == Orientation.portrait
                    //                 ? size.height * 0.25
                    //                 : size.height * 0.5,
                    //             decoration: BoxDecoration(
                    //               color: Colors.red,
                    //               borderRadius: BorderRadius.circular(10),
                    //               image: DecorationImage(
                    //                 fit: BoxFit.fill,
                    //                 image: CachedNetworkImageProvider(
                    //                   'https://image.tmdb.org/t/p/original${data.results[index].posterPath}',
                    //                 ),
                    //               ),
                    //             ),
                    //             child: Stack(
                    //               children: [
                    //                 Positioned.fill(
                    //                   child: Container(
                    //                     decoration: BoxDecoration(
                    //                       borderRadius: const BorderRadius.only(
                    //                         bottomLeft: Radius.circular(10),
                    //                         bottomRight: Radius.circular(10),
                    //                       ),
                    //                       gradient: LinearGradient(
                    //                         begin: Alignment.bottomCenter,
                    //                         end: Alignment.topCenter,
                    //                         colors: [
                    //                           Colors.black.withOpacity(0.7),
                    //                           Colors.transparent,
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Align(
                    //                     alignment: Alignment.bottomLeft,
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.all(16.0),
                    //                       child: Text(
                    //                         data.results[index].title,
                    //                         style: AppStyles
                    //                             .watchMovieNameTextstyle,
                    //                       ),
                    //                     )),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           height: size.height * 0.02,
                    //         ),
                    //       ],
                    //     );

                    //   },
                    // ),
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
