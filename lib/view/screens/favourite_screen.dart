import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_finder/controllers/fav_recipe_controller.dart';
import 'package:recipe_finder/routes.dart';
import 'package:recipe_finder/utils/colors.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FavRecipeController favRecipeController =
      Get.find<FavRecipeController>();
  // final RecipeController recipeController = Get.find<RecipeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favRecipeController.getRecipesByFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 9,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [AppColors.purple, AppColors.blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                MediaQuery.of(context).size.width, 105.0))),
                  ),
                  const Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "Favourite Recipe",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 18.0, left: 18.0, top: 18.0),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            mainAxisExtent: 230),
                    itemCount: favRecipeController.favRecipeIds.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("favRecipe: ${favRecipeController.favRecipeIds}");
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(GetRoutes.detail);
                        },
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(16.0),
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: AppColors.blue),
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0)),
                                      child: Image.asset(
                                        'assets/images/girlcook.jpg',
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )),
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'title',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.favorite_outlined,
                                  color: AppColors.purple,
                                ),
                                onPressed: () {
                                  const Icon(Icons.favorite_outline);
                                },
                              ),
                            ),
                          ]),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
