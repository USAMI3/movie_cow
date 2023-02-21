// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:movie_cow/core/app/colors.dart';
import 'package:movie_cow/core/app/texts.dart';
import 'package:movie_cow/core/services/api/api_services.dart';
import 'package:movie_cow/views/widgets/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatelessWidget {
  final int movieId;

  VideoPlayerScreen({
    required this.movieId,
    Key? key,
  }) : super(key: key);

  final ApiRequests apiRequests = ApiRequests();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;
    return FutureBuilder<String>(
      future: apiRequests.getMovieTrailerUrl(movieId),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          final String? videoId = YoutubePlayer.convertUrlToId(snapshot.data!);

          return Scaffold(
            backgroundColor: AppColors.blueGreyColor,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    YoutubePlayer(
                      aspectRatio: 16 / 10,
                      onEnded: (YoutubeMetaData metaData) {
                        finish(context);
                      },
                      controller: YoutubePlayerController(
                        initialVideoId: videoId!,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    InkWell(
                      onTap: () {
                        finish(context);
                      },
                      child: Container(
                        width: orientation == Orientation.portrait
                            ? size.width * 0.5
                            : size.width * 0.25,
                        height: orientation == Orientation.portrait
                            ? size.height * 0.07
                            : size.height * 0.15,
                        decoration: BoxDecoration(
                          color: AppColors.yellowColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                            child: Text(
                          AppTexts.videoPlayerDone,
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontFamily: AppTexts.boldAppFont,
                            fontSize: 16,
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(
            child: LoaderWidget(),
          );
        }
      },
    );
  }
}
