import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/view/introPage.dart';

void main() {
  testWidgets('IntroPage loads and shows the button', (WidgetTester tester) async {
    // ابني الصفحة الأساسية
    await tester.pumpWidget(const MaterialApp(home: Intropage()));

    // دور على الزر اللي بيجيب حالة الطقس
    expect(find.text('Weather in your area'), findsOneWidget);
  });
}
