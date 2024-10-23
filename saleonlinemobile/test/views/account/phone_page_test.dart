import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/mainProvider/main_provider.dart';
import 'package:saleonlinemobile/views/account/phone_page.dart';

void main() {
  testWidgets("Test Phone Page widget", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: MainProvider.provider(),
        child: const MaterialApp(
          home: PhonePage(),
        )));

    // Init widget
    await tester.pump();

    // get widget by key
    final appbar = find.byKey(const ValueKey('appbar'));
    expect(appbar, findsOneWidget);

    final title = find.byKey(const ValueKey('title'));
    expect(title, findsOneWidget);

    final safeArea = find.byKey(const ValueKey('safe_area'));
    expect(safeArea, findsOneWidget);

    final container = find.byKey(const ValueKey('container'));
    expect(container, findsOneWidget);

    final colColumn = find.byKey(const ValueKey('col_column'));
    expect(colColumn, findsOneWidget);

    final cachImage = find.byKey(const ValueKey('cach_image'));
    expect(cachImage, findsOneWidget);

    final labelEmail = find.byKey(const ValueKey('label_phone'));
    expect(labelEmail, findsOneWidget);

    final containBtn = find.byKey(const ValueKey('contain_btn'));
    expect(containBtn, findsOneWidget);

    final input = find.byKey(const ValueKey('input'));
    expect(input, findsOneWidget);
  });
}
