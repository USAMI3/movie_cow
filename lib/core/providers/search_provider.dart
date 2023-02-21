// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_cow/core/services/api/models/search_movie_model.dart';

import '../services/api/search_service.dart';

final ChangeNotifierProvider<MovieProvider> searchmovieProvider =
    ChangeNotifierProvider(
        (ChangeNotifierProviderRef<MovieProvider> ref) => MovieProvider());

class MovieProvider extends ChangeNotifier {
  final MovieService _movieService = MovieService();
  String _query = '';
  List<SearchResult> _movies = [];

  bool _haveSearched = false;
  bool get haveSearched => _haveSearched;

  void searchedPrompt() {
    _haveSearched = !_haveSearched;
    notifyListeners();
  }

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
