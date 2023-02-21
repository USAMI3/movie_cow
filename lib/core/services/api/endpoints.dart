class Endpoints {
  Endpoints._();
  static const String baseUrl = 'https://api.themoviedb.org';
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static const int receiveTimeout = 30000;
  static const int connectionTimeout = 30000;
  static const String getMovies = '/3/movie/upcoming';
  //in production mode, store sensitive data in secure place i.e. in .env file
  static const String apiKey = '55d31ecf304933f3d06bf2ff11c2b947';
}
