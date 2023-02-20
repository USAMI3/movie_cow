import 'dart:convert';

import 'package:movie_cow/core/services/api/endpoints.dart';
import 'package:movie_cow/core/services/api/models/movie_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRequests {
  //get movies
  Future<MovieModel> getUpcomingMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? moviesData = prefs.getString('upcoming_movies');
    if (moviesData != null) {
      print("I'm being called now");
      return MovieModel.fromJson(json.decode(moviesData));
    } else {
      try {
        print("i was called");
        const String url = Endpoints.baseUrl + Endpoints.getMovies;
        print(url);
        //for production purposes, use api_key more securely, i.e in .env file
        final Map<String, String> queryParameters = {
          'api_key': '55d31ecf304933f3d06bf2ff11c2b947',
        };
        return await Dio()
            .get(
          url,
          queryParameters: queryParameters,
        )
            .then((Response value) {
          print(value);
          prefs.setString('upcoming_movies', json.encode(value.data));
          return MovieModel.fromJson(value.data);
        });
      } on DioError catch (e) {
        Map<String, String> errorResponse = {'status': e.message};
        return MovieModel.fromJson(errorResponse);
      }
    }
  }

  //get trailer url
  Future<String> getMovieTrailerUrl(int movieId) async {
    final dio = Dio();
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=55d31ecf304933f3d06bf2ff11c2b947&language=en-US');
    final results = response.data['results'];
    if (results != null && results.isNotEmpty) {
      final trailer = results.firstWhere(
          (result) => result['type'] == 'Trailer',
          orElse: () => results.first);
      final key = trailer['key'];
      print('https://www.youtube.com/watch?v=$key');
      return 'https://www.youtube.com/watch?v=$key';
    } else {
      return '';
    }
  }
}
