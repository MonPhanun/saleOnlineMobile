import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/mainProvider/main_provider.dart';
import 'package:saleonlinemobile/views/home/home_page.dart';

void main() {
  testWidgets("Test Home Page widget", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: MainProvider.provider(),
        child: const MaterialApp(
          home: Scaffold(
            body: SafeArea(child: HomePage()),
          ),
        )));
    // Init widget
    await tester.pump();

    // get widget by key
    final content = find.byKey(const ValueKey('content'));
    expect(content, findsOneWidget);

    final refresh = find.byKey(const ValueKey('refresh'));
    expect(refresh, findsOneWidget);

    final header = find.byKey(const ValueKey('header'));
    expect(header, findsOneWidget);

    final category = find.byKey(const ValueKey('category'));
    expect(category, findsOneWidget);

    final listviewContent = find.byKey(const ValueKey('listview_content'));
    expect(listviewContent, findsOneWidget);

    final builders = find.byKey(const ValueKey('builder'));
    expect(builders, findsOneWidget);

    final slider = find.byKey(const ValueKey('slider'));
    expect(slider, findsOneWidget);

    final contentCart = find.byKey(const ValueKey('content_cart'));
    expect(contentCart, findsOneWidget);
  });
}
