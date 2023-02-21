import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_cow/core/services/api/models/search_movie_model.dart';
import 'package:riverpod/riverpod.dart';

import '../services/api/search_service.dart';

final searchmovieProvider = ChangeNotifierProvider((ref) => MovieProvider());

class MovieProvider extends ChangeNotifier {
  final MovieService _movieService = MovieService();
  String _query = '';
  List<SearchResult> _movies = [];

  String get query => _query;
  set query(String value) {
    _query = value;
    searchMovies();
  }

  List<SearchResult> get movies => _movies;

  Future<void> searchMovies() async {
    _movies = await _movieService.searchMovies(_query);
    notifyListeners();
  }
}
