import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lion_flowers/data/products.dart';
import 'package:lion_flowers/main.dart';

void main() {
  testWidgets('muestra la bienvenida y luego abre la tienda', (tester) async {
    await tester.pumpWidget(const LionFlowersApp());

    expect(find.text('Lion Flowers'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Bienvenida a Lion Flowers'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Categorías'), findsOneWidget);
    expect(find.text('Arreglos para alegrar tu día'), findsOneWidget);
    expect(floralProducts, hasLength(10));
  });

  testWidgets('se puede añadir un arreglo a favoritos', (tester) async {
    await tester.pumpWidget(const LionFlowersApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Añadir a favoritos').first);
    await tester.pump();
    expect(find.text('Añadido a tus favoritos'), findsOneWidget);

    await tester.tap(find.text('Favoritos').last);
    await tester.pumpAndSettle();
    expect(find.text('Rosas de jardín'), findsOneWidget);
  });

  testWidgets('categorías filtra el catálogo y no desborda en móvil', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(720, 1600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const LionFlowersApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Categorías').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rosas').first);
    await tester.pumpAndSettle();

    expect(find.text('Rosas de jardín'), findsOneWidget);
    expect(find.text('Día de peonías'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
