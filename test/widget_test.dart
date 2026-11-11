// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cirunay_calculator/main.dart';

void main() {
  testWidgets('Calculator performs operations, handles errors, and clears', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalculatorApp());

    expect(find.text('My Stateful Calculator'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Enter two numbers'), findsOneWidget);
    expect(
      find.text('Created by: Niño Angelo C. Cirunay\nSection: CCE106L(3447)'),
      findsOneWidget,
    );

    final firstField = find.widgetWithText(TextField, 'First Number');
    final secondField = find.widgetWithText(TextField, 'Second Number');

    await tester.enterText(firstField, '12');
    await tester.enterText(secondField, '8');
    await tester.tap(find.text('+'));
    await tester.pump();

    expect(find.text('20.0'), findsOneWidget);
    expect(find.text('12.0 + 8.0'), findsOneWidget);

    await tester.enterText(secondField, '0');
    await tester.tap(find.text('÷'));
    await tester.pump();

    expect(find.text('Cannot divide by zero'), findsOneWidget);
    expect(find.text('Please change the second number'), findsOneWidget);

    await tester.ensureVisible(find.text('Clear'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clear'));
    await tester.pump();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('Enter two numbers'), findsOneWidget);
  });
}
