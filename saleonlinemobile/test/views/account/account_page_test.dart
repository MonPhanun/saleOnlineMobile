import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/mainProvider/main_provider.dart';
import 'package:saleonlinemobile/views/account/account_page.dart';

void main() {
  testWidgets("Test Account Page widget", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: MainProvider.provider(),
        child: const MaterialApp(
          home: Scaffold(
            body: SafeArea(child: AccountPage()),
          ),
        )));

    // Init widget
    await tester.pump();

    // get widget by key
    final refresh = find.byKey(const ValueKey('refresh'));
    expect(refresh, findsOneWidget);

    final content = find.byKey(const ValueKey('content'));
    expect(content, findsOneWidget);

    final header = find.byKey(const ValueKey('header'));
    expect(header, findsOneWidget);

    final listContent = find.byKey(const ValueKey('list_content'));
    expect(listContent, findsOneWidget);

    final mailBtn = find.byKey(const ValueKey('mail_btn'));
    expect(mailBtn, findsOneWidget);

    final mailContaint = find.byKey(const ValueKey('mail_containt'));
    expect(mailContaint, findsOneWidget);

    final phoneBtn = find.byKey(const ValueKey('phone_btn'));
    expect(phoneBtn, findsOneWidget);
  });
}
