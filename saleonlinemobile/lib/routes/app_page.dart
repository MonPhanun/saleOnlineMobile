import 'package:get/get.dart';
import 'package:saleonlinemobile/controller/dashboard_binding.dart';
import 'package:saleonlinemobile/routes/app_route.dart';
import 'package:saleonlinemobile/views/account/mail_page.dart';
import 'package:saleonlinemobile/views/account/phone_page.dart';
import 'package:saleonlinemobile/views/cart/cart_page.dart';
import 'package:saleonlinemobile/views/dashboard/dashboard_screen.dart';
import 'package:saleonlinemobile/views/productDetail/product_detail_page.dart';
import 'package:saleonlinemobile/views/revieworder/review_order_page.dart';
import 'package:saleonlinemobile/views/viewmore/view_more_product_page.dart';

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
    GetPage(
      name: AppRoute.detail,
      page: () => const ProductDetailPage(),
    ),
    GetPage(
      name: AppRoute.reviewOrder,
      page: () => const ReviewOrderPage(),
    ),
    GetPage(
      name: AppRoute.viewmore,
      page: () => const ViewMoreProductPage(),
    ),
    GetPage(
      name: AppRoute.mail,
      page: () => const MailPage(),
    ),
    GetPage(
      name: AppRoute.phone,
      page: () => const PhonePage(),
    ),
  ];
}
