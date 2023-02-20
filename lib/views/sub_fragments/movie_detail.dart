import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_cow/core/app/colors.dart';
import 'package:movie_cow/core/app/styles.dart';
import 'package:movie_cow/core/app/texts.dart';
import 'package:movie_cow/core/services/api/api_services.dart';
import 'package:movie_cow/core/services/api/models/movie_model.dart';
import 'package:movie_cow/views/widgets/video_player.dart';
import 'package:nb_utils/nb_utils.dart';

class MovieDetail extends ConsumerStatefulWidget {
  final Result result;
  const MovieDetail(this.result, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDetailState();
}

class _MovieDetailState extends ConsumerState<MovieDetail> {
  final apiRequests = ApiRequests();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.55,
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
                            "In Theatres",
                            style: AppStyles.movieDetailTheatreTextstyle,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Container(
                            width: size.width * 0.6,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              color: AppColors.lightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              VideoPlayerScreen(
                                movieId: widget.result.id,
                              ).launch(context);
                            },
                            child: Container(
                              width: size.width * 0.6,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                color: AppColors.lightColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    AppTexts.watchAppBarTitle,
                    style: AppStyles.watchAppBarTextstyleWhite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
