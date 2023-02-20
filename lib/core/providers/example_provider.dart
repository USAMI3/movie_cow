import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ExampleProvider> exampleProvider =
    Provider((ProviderRef<ExampleProvider> ref) {
  return ExampleProvider(ref);
});

class ExampleProvider {
  ExampleProvider(this._ref);
  final Ref _ref;

  String exampleVariableHome = 'Home view';
  String exampleVariableLogin = 'Login view';

  void examplePublicFunction() {
    // Do something like call an API
    // E.g:
    // await _ref.read(projectsApiProvider).getProjectById(1);
  }
}
