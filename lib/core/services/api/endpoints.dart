class Endpoints {
  Endpoints._();
  static const String baseUrl = 'https://api.themoviedb.org';
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static const int receiveTimeout = 30000;
  static const int connectionTimeout = 30000;
  static const String getMovies = '/3/movie/upcoming';
}
