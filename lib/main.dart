import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:saleonlinemobile/routes/app_page.dart';
import 'package:saleonlinemobile/routes/app_route.dart';
import 'package:saleonlinemobile/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      getPages: AppPage.list,
      initialRoute: AppRoute.cart,
    );
  }
}
