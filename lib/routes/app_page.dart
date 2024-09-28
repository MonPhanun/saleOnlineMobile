import 'package:get/get.dart';
import 'package:saleonlinemobile/controller/dashboard_binding.dart';
import 'package:saleonlinemobile/routes/app_route.dart';
import 'package:saleonlinemobile/views/cart/cart_page.dart';
import 'package:saleonlinemobile/views/dashboard/dashboard_screen.dart';

class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.dashboard,
        page: () => const DashboardScreen(),
        binding: DashboardBinding()),
    GetPage(
      name: AppRoute.cart,
      page: () => const CartPage(),
    ),
  ];
}
