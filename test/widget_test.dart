import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Text widget displays correct message',
      (WidgetTester tester) async {
    const String message = 'Watch';
    await tester.pumpWidget(const Directionality(
        textDirection: TextDirection.ltr, child: Text(message)));
    expect(find.text(message), findsOneWidget);
  });
}
