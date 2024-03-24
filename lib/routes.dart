import 'package:get/get.dart';
import 'package:recipe_finder/view/screens/detail_screen.dart';
import 'package:recipe_finder/view/screens/favourite_screen.dart';
import 'package:recipe_finder/view/screens/home_screen.dart';
import 'package:recipe_finder/view/screens/splash_screen.dart';
import 'package:recipe_finder/widgets/bottombar.dart';

class GetRoutes {
  static const String splash = "/splash";
  static const String bottombar = "/bottombar";
  static const String home = "/home";
  static const String detail = "/detail";
  static const String favourite = "/favourite";

  static List<GetPage> routes = [
    GetPage(
      name: GetRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: GetRoutes.bottombar,
      page: () => BottomBar(),
    ),
    GetPage(
      name: GetRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: GetRoutes.detail,
      page: () => const DetailScreen(),
    ),
    GetPage(
      name: GetRoutes.favourite,
      page: () => const FavouriteScreen(),
    )
  ];
}
