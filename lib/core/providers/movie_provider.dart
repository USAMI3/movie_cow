import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<MovieProvider> movieProvider =
    ChangeNotifierProvider((ChangeNotifierProviderRef<MovieProvider> ref) {
  return MovieProvider(ref);
});

class MovieProvider extends ChangeNotifier {
  MovieProvider(this._ref);
  final Ref _ref;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSearching = false;
  bool get isSearching => _isSearching;

  void searchPrompt() {
    print("I was clicked");
    _isSearching = !_isSearching;
    notifyListeners();
    print(_isSearching);
  }
}
