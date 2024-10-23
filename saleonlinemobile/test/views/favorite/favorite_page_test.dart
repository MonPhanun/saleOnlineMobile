import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/mainProvider/main_provider.dart';
import 'package:saleonlinemobile/views/favorite/favorite_page.dart';

void main() {
  testWidgets("Test Favorite Page widget", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: MainProvider.provider(),
        child: const MaterialApp(
          home: Scaffold(
            body: SafeArea(child: FavoritePage()),
          ),
        )));

    // Init widget
    await tester.pumpAndSettle();

    // get widget by key
    final scrollRefresh = find.byKey(const ValueKey('scroll_refresh'));
    expect(scrollRefresh, findsOneWidget);

    final header = find.byKey(const ValueKey('header'));
    expect(header, findsOneWidget);

    final category = find.byKey(const ValueKey('category'));
    expect(category, findsOneWidget);

    final futureBuilder = find.byKey(const ValueKey('future_builder'));
    expect(futureBuilder, findsOneWidget);

    final content = find.byKey(const ValueKey('content'));
    expect(content, findsOneWidget);
  });
}
