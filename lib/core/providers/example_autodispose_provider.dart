import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeChangeNotifierProvider<ExampleProvider> exampleAutoDisposeProvider = ChangeNotifierProvider.autoDispose((ChangeNotifierProviderRef<ExampleProvider> ref) {
  return ExampleProvider(ref);
});

class ExampleProvider extends ChangeNotifier {
  ExampleProvider(this._ref);
  final Ref _ref;
  int _counterValue = 0;
  // Project? _currentProject;

  int get counterValue => _counterValue;

  void examplePublicFunction() {
    // Do something like call an API
    // E.g:
    // _currentProject = await _ref.read(projectsApiProvider).getProjectById(1);

    // And then update any Widgets listening to this provider
    // E.g:
    // notifiyListeners();
  }

  void incrementCounter() {
    _counterValue += 1;
    notifyListeners();
  }
}
