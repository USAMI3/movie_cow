// ignore_for_file: always_specify_types, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
    print('I was clicked');
    _isSearching = !_isSearching;
    notifyListeners();
    print(_isSearching);
  }

  String formatDate(String dateStr) {
    // Parse the input date string into a DateTime object
    DateTime date = DateTime.parse(dateStr);
    // Define the desired output format
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');
    // Format the date using the formatter
    final String formattedDate = formatter.format(date);

    return formattedDate;
  }
}
