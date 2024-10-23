import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/mainProvider/main_provider.dart';
import 'package:saleonlinemobile/views/search/search_page.dart';

void main() {
  testWidgets("Test Search Page widget", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: MainProvider.provider(),
        child: const MaterialApp(
          home: Scaffold(
            body: SafeArea(child: SearchPage()),
          ),
        )));

    // Init widget
    await tester.pump();

    // get widget by key
    final scrollRefresh = find.byKey(const ValueKey('scroll_refresh'));
    expect(scrollRefresh, findsOneWidget);

    final content = find.byKey(const ValueKey('content'));
    expect(content, findsOneWidget);

    final header = find.byKey(const ValueKey('header'));
    expect(header, findsOneWidget);

    final category = find.byKey(const ValueKey('category'));
    expect(category, findsOneWidget);

    final sponsered = find.byKey(const ValueKey('sponsered'));
    expect(sponsered, findsOneWidget);

    final listContent = find.byKey(const ValueKey('list_content'));
    expect(listContent, findsOneWidget);

    final listSmallCart = find.byKey(const ValueKey('list_small_cart'));
    expect(listSmallCart, findsOneWidget);

    final result = find.byKey(const ValueKey('result'));
    expect(result, findsOneWidget);

    final textPrice = find.byKey(const ValueKey('text_price'));
    expect(textPrice, findsOneWidget);

    final gridView = find.byKey(const ValueKey('grid_view'));
    expect(gridView, findsOneWidget);
  });
}
