import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

final ChangeNotifierProvider<ExampleProvider> exampleChangeNotifierProvider =
    ChangeNotifierProvider((ChangeNotifierProviderRef<ExampleProvider> ref) {
  return ExampleProvider(ref);
});

class ExampleProvider extends ChangeNotifier {
  ExampleProvider(this._ref);
  final Ref _ref;
  int _counterValue = 0;
  bool _isLoading = false;
  // Project? _currentProject;

  int get counterValue => _counterValue;
  bool get isLoading => _isLoading;

  void examplePublicFunction() {
    // Do something like call an API
    // E.g:
    // _currentProject = await _ref.read(projectsApiProvider).getProjectById(1);

    // And then update any Widgets listening to this provider
    // E.g:
    // notifiyListeners();
  }
  Future<void> callingApiTest() async {
    print("I am called");
    _isLoading = true;
    notifyListeners();
    await 5.seconds.delay;
    _isLoading = false;
    print("I am here now");
    notifyListeners();
  }

  void incrementCounter() {
    _counterValue += 1;
    notifyListeners();
  }
}
