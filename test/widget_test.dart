import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_lavoura/main.dart';

void main() {
  testWidgets('O app sobe e mostra o título na AppBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CalculadoraApp());
    expect(find.text('Receita da Lavoura'), findsOneWidget);
  });
}
