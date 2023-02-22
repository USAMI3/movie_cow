// ignore_for_file: always_specify_types

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
      return MovieModel.fromJson(json.decode(moviesData));
    } else {
      try {
        const String url = Endpoints.baseUrl + Endpoints.getMovies;

        final Map<String, String> queryParameters = {
          'api_key': Endpoints.apiKey,
        };
        return await Dio()
            .get(
          url,
          queryParameters: queryParameters,
        )
            .then((Response value) {
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
    try {
      final Dio dio = Dio();
      final Response response = await dio.get(
          'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=${Endpoints.apiKey}&language=en-US');
      final results = response.data['results'];
      if (results != null && results.isNotEmpty) {
        final trailer = results.firstWhere(
            (result) => result['type'] == 'Trailer',
            orElse: () => results.first);
        final key = trailer['key'];
        return 'https://www.youtube.com/watch?v=$key';
      } else {
        return '';
      }
    } on DioError catch (e) {
      print('Error getting movie trailer URL: ${e.message}');
      return '';
    } catch (e) {
      print('Error getting movie trailer URL: $e');
      return '';
    }
  }

  //get genres
  Future<Map<int, String>> fetchGenres() async {
    final Dio dio = Dio();
    final Response response = await dio.get(
        'https://api.themoviedb.org/3/genre/movie/list',
        queryParameters: {'api_key': Endpoints.apiKey});
    if (response.statusCode == 200) {
      final List<dynamic> genresJson = response.data['genres'];
      final Map<int, String> genres = {};
      for (var genre in genresJson) {
        genres[genre['id']] = genre['name'];
      }
      return genres;
    } else {
      throw Exception('Failed to fetch genres');
    }
  }
}
