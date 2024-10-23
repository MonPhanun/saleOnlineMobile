import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/mainProvider/main_provider.dart';
import 'package:saleonlinemobile/views/revieworder/review_order_page.dart';

void main() {
  testWidgets("Test Review Order Page widget", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: MainProvider.provider(),
        child: const MaterialApp(
          home: Scaffold(
            body: SafeArea(child: ReviewOrderPage()),
          ),
        )));

    // Init widget
    await tester.pump();

    // get widget by key
    final appbar = find.byKey(const ValueKey('appbar'));
    expect(appbar, findsOneWidget);

    // final content = find.byKey(const ValueKey('content'));
    // expect(content, findsOneWidget);

    // final header = find.byKey(const ValueKey('header'));
    // expect(header, findsOneWidget);

    // final listviewContent = find.byKey(const ValueKey('listview_content'));
    // expect(listviewContent, findsOneWidget);

    // final dateContent = find.byKey(const ValueKey('date_content'));
    // expect(dateContent, findsOneWidget);

    // final productCart = find.byKey(const ValueKey('product_cart'));
    // expect(productCart, findsOneWidget);

    // final cartTotal = find.byKey(const ValueKey('cart_total'));
    // expect(cartTotal, findsOneWidget);
  });
}
