import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_lavoura/main.dart';

void main() {
  testWidgets('O app sobe e mostra o título na AppBar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalculadoraApp());
    expect(find.text('Calculadora de Adubação'), findsOneWidget);
  });

  testWidgets('Mostra o card de erro na tela após um cálculo inválido', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalculadoraApp());

    await tester.tap(find.text('Calcular'));
    await tester.pumpAndSettle();

    final mensagem = find.text('Por favor, insira valores válidos nos campos.');
    expect(mensagem, findsOneWidget);

    final retangulo = tester.getRect(mensagem);
    final alturaViewport =
        tester.view.physicalSize.height / tester.view.devicePixelRatio;
    expect(retangulo.top, greaterThanOrEqualTo(0));
    expect(retangulo.bottom, lessThanOrEqualTo(alturaViewport));
  });
}
