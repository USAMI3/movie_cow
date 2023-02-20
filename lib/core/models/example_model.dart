class ExampleModel {
  ExampleModel({
    required this.id,
    required this.message,
    this.optionalValue,
  });

  final int id;
  final String message;
  final bool? optionalValue;
}
