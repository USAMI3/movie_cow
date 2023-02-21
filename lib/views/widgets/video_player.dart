import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:movie_cow/core/app/colors.dart';
import 'package:movie_cow/core/app/texts.dart';
import 'package:movie_cow/core/services/api/api_services.dart';
import 'package:movie_cow/views/widgets/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatelessWidget {
  final int movieId;

  VideoPlayerScreen({Key? key, required this.movieId}) : super(key: key);

  final apiRequests = ApiRequests();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder<String>(
      future: apiRequests.getMovieTrailerUrl(movieId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final videoId = YoutubePlayer.convertUrlToId(snapshot.data!);

          return Scaffold(
            backgroundColor: AppColors.blueGreyColor,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    YoutubePlayer(
                      aspectRatio: 16 / 10,
                      onEnded: (metaData) {
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
                        width: size.width * 0.5,
                        height: size.height * 0.07,
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
          return Center(
            child: LoaderWidget(),
          );
        }
      },
    );
  }
}
