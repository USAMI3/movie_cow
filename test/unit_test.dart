// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_cow/core/services/api/api_services.dart';

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
}
