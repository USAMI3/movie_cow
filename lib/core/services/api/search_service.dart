// ignore_for_file: always_specify_types

import 'package:dio/dio.dart';
import 'package:movie_cow/core/services/api/models/search_movie_model.dart';

import 'endpoints.dart';

class MovieService {
  final Dio _dio = Dio();

  Future<List<SearchResult>> searchMovies(String query) async {
    final String url =
        'https://api.themoviedb.org/3/search/movie?api_key=${Endpoints.apiKey}&query=$query&page=1&with_original_language=en';

    try {
      final Response response = await _dio.get(url);
      final SearchMovieModel searchMovieModel =
          SearchMovieModel.fromJson(response.data);
      return searchMovieModel.results;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
