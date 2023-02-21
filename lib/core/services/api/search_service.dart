import 'package:dio/dio.dart';
import 'package:movie_cow/core/services/api/endpoints.dart';
import 'package:movie_cow/core/services/api/models/search_movie_model.dart';

class MovieService {
  final Dio _dio = Dio();

  Future<List<SearchResult>> searchMovies(String query) async {
    final url =
        'https://api.themoviedb.org/3/search/movie?api_key=55d31ecf304933f3d06bf2ff11c2b947&query=$query&page=1&with_original_language=en';
    print(url);
    try {
      final response = await _dio.get(url);
      final searchMovieModel = SearchMovieModel.fromJson(response.data);
      return searchMovieModel.results;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
