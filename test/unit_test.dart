import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movie_cow/core/services/api/api_services.dart';
import 'package:movie_cow/core/services/api/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('getMovieTrailerUrl', () {
    test('returns valid trailer URL for a movie ID', () async {
      final ApiRequests api = ApiRequests();
      final String trailerUrl = await api
          .getMovieTrailerUrl(550); // The movie ID for the movie 'Fight Club'
      expect(trailerUrl, isNotEmpty);
      expect(trailerUrl, startsWith('https://www.youtube.com/watch?v='));
    });

    test('returns empty string for invalid movie ID', () async {
      final ApiRequests api = ApiRequests();
      final String trailerUrl =
          await api.getMovieTrailerUrl(-1); // An invalid movie ID
      expect(trailerUrl, isEmpty);
    });
    test('handles Dio errors gracefully', () async {
      final ApiRequests api = ApiRequests();
      final String trailerUrl =
          await api.getMovieTrailerUrl(999999999); // A non-existent movie ID
      expect(trailerUrl, isEmpty);
    });
  });
  group('testGenreFetch', () {
    test('returns valid genre data', () async {
      final ApiRequests api = ApiRequests();
      final genres = await api.fetchGenres();
      expect(genres, isNotEmpty);
      expect(genres, isMap);
    });
  });

  // group('testMovieFetch', () {
  //   setUp(() {
  //     TestWidgetsFlutterBinding.ensureInitialized();
  //     const MethodChannel('plugins.flutter.io/shared_preferences')
  //         .setMockMethodCallHandler((MethodCall methodCall) async {
  //       if (methodCall.method == 'getAll') {
  //         return <String, dynamic>{};
  //       }
  //       return null;
  //     });
  //   });
  //   test('returns valid movie data', () async {
  //     final ApiRequests api = ApiRequests();
  //     final movies = await api.getUpcomingMovies();
  //     expect(movies, isInstanceOf<MovieModel>());
  //   });
  // });
}
