import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/mainProvider/main_provider.dart';
import 'package:saleonlinemobile/views/cart/cart_page.dart';

void main() {
  testWidgets("Test Cart Page widget", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: MainProvider.provider(),
        child: const MaterialApp(
          home: CartPage(),
        )));
    TestWidgetsFlutterBinding.ensureInitialized();
    // Init widget
    await tester.pump();

    // get widget by keyc
    final appbar = find.byKey(const ValueKey('appbar'));
    expect(appbar, findsOneWidget);

    final input = find.byKey(const ValueKey('input'));
    expect(input, findsOneWidget);

    final refresh = find.byKey(const ValueKey('refresh'));
    expect(refresh, findsOneWidget);

    final futureBuilder = find.byKey(const ValueKey('future_builder'));
    expect(futureBuilder, findsOneWidget);
  });
}
