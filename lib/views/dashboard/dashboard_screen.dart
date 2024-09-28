import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:saleonlinemobile/controller/dashboard_controller.dart';
import 'package:saleonlinemobile/views/favorite/favorite_page.dart';
import 'package:saleonlinemobile/views/home/home_page.dart';
import 'package:saleonlinemobile/views/orderstory/order_story_page.dart';
import 'package:saleonlinemobile/views/search/search_page.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SafeArea(
            child: IndexedStack(
          index: controller.tabIndex,
          children: [
            // Home page
            const HomePage(),

            // Favorite page
            const FavoritePage(),

            // Search page
            const SearchPage(),

            // Order story
            const OrderStoryPage(),

            // Account
            Container(
              color: Colors.deepOrange[200],
            ),
          ],
        )),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 0.4))),
          child: SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.floating,
            snakeShape: SnakeShape.circle,
            padding: const EdgeInsets.symmetric(vertical: 4),
            unselectedLabelStyle: const TextStyle(fontSize: 11),
            snakeViewColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).colorScheme.primary,
            showUnselectedLabels: true,
            currentIndex: controller.tabIndex,
            onTap: (val) {
              controller.updateIndex(val);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag,
                    size: 26,
                  ),
                  label: 'Order history'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.keyboard_control_sharp), label: 'Account'),
            ],
          ),
        ),
      );
    });
  }
}
