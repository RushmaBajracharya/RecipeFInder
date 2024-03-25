import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_finder/controllers/bottomNavBarController.dart';
import 'package:recipe_finder/view/screens/favourite_screen.dart';
import 'package:recipe_finder/view/screens/home_screen.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final BottomNavBarController controller = Get.put(BottomNavBarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return HomeScreen();
          case 1:
            return const FavouriteScreen();
          default:
            return Container();
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 208, 213, 237),
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
          )),
    );
  }
}
