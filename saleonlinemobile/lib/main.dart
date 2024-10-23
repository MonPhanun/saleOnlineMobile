import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/routes/app_page.dart';
import 'package:saleonlinemobile/routes/app_route.dart';
import 'package:saleonlinemobile/stateProvider/mainProvider/main_provider.dart';
import 'package:saleonlinemobile/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(MultiProvider(
    providers: MainProvider.provider(),
    child: const MyApp(),
  ));
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
      initialRoute: AppRoute.dashboard,
    );
  }
}
