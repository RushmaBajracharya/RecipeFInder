import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_finder/controllers/recipeController.dart';
import 'package:recipe_finder/routes.dart';
import 'package:recipe_finder/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    RecipeController recipeController = Get.put(RecipeController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
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
                  Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        const Center(
                          child: Text(
                            "Recipe Finder",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //Searchbar start
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15),
                                  hintText: "Search",
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {},
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  )),
                            ),
                          ),
                        )

                        //Searchbar end
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(right: 18.0, left: 18.0, top: 18.0),
                  child: Obx(() {
                    if (recipeController.isLoading.value) {
                      return CircularProgressIndicator(); // Show loading indicator if the recipe list is empty
                    } else {
                      return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  mainAxisExtent: 270),
                          itemCount: recipeController.recipeNames.length,
                          itemBuilder: (BuildContext context, int index) {
                            final recipe = recipeController.recipeNames[index];
                            final imageUrl = recipeController.recipesUrl[index];
                            final instructions =
                                recipeController.recipeInstructions[index];
                            final ingredients =
                                recipeController.recipesIngredients[index];

                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  GetRoutes.detail,
                                  arguments: {
                                    'recipeName': recipe,
                                    'imageUrl': imageUrl,
                                    'instructions': instructions,
                                    'ingredients': ingredients,
                                  },
                                );
                              },
                              child: Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(16.0),
                                child: Stack(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        color: AppColors.blue),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(16.0)),
                                          child: Image.network(
                                            imageUrl,
                                            height: 180,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              recipe,
                                              style: const TextStyle(
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
                                      icon: const Icon(Icons.favorite_outline),
                                      onPressed: () {
                                        const Icon(
                                          Icons.favorite_outlined,
                                          color: AppColors.purple,
                                        );
                                      },
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          });
                    }
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
