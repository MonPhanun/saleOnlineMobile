import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/mainProvider/main_provider.dart';
import 'package:saleonlinemobile/views/viewmore/view_more_product_page.dart';

void main() {
  testWidgets("Test View More Page widget", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: MainProvider.provider(),
        child: const MaterialApp(
          home: ViewMoreProductPage(),
        )));

    // Init widget
    await tester.pump();

    // get widget by key
    final refresh = find.byKey(const ValueKey('refresh'));
    expect(refresh, findsOneWidget);

    final safeArea = find.byKey(const ValueKey('safe_area'));
    expect(safeArea, findsOneWidget);

    final appbar = find.byKey(const ValueKey('appbar'));
    expect(appbar, findsOneWidget);

    final header = find.byKey(const ValueKey('header'));
    expect(header, findsOneWidget);

    final category = find.byKey(const ValueKey('category'));
    expect(category, findsOneWidget);

    final futureBuilder = find.byKey(const ValueKey('future_builder'));
    expect(futureBuilder, findsOneWidget);
  });
}
