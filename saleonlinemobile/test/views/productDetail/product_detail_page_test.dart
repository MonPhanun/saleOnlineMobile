import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/mainProvider/main_provider.dart';
import 'package:saleonlinemobile/views/productDetail/product_detail_page.dart';

void main() {
  testWidgets("Test Product Detail Page widget", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: MainProvider.provider(),
        child: const MaterialApp(
          home: ProductDetailPage(),
        )));

    // Init widget
    await tester.pump();

    // get widget by keyc
    final appbar = find.byKey(const ValueKey('appbar'));
    expect(appbar, findsOneWidget);

    final refresh = find.byKey(const ValueKey('refresh'));
    expect(refresh, findsOneWidget);

    final colContent = find.byKey(const ValueKey('col_content'));
    expect(colContent, findsOneWidget);

    final header = find.byKey(const ValueKey('header'));
    expect(header, findsOneWidget);

    final futureBuilder = find.byKey(const ValueKey('future_builder'));
    expect(futureBuilder, findsOneWidget);

    final listView = find.byKey(const ValueKey('list_view'));
    expect(listView, findsOneWidget);

    final store = find.byKey(const ValueKey('store'));
    expect(store, findsOneWidget);

    final storeName = find.byKey(const ValueKey('store_name'));
    expect(storeName, findsOneWidget);

    final storeQty = find.byKey(const ValueKey('store_qty'));
    expect(storeQty, findsOneWidget);

    final slideImage = find.byKey(const ValueKey('slide_image'));
    expect(slideImage, findsOneWidget);

    final indicator = find.byKey(const ValueKey('indicator'));
    expect(indicator, findsOneWidget);
  });
}
