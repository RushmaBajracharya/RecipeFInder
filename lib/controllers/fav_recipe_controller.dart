import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FavRecipeController extends GetxController {
  late RxList<RxInt> favRecipeIds;
  RxBool isLoading = true.obs;
  String jsonString = '';
  List recipes = [].obs;

  List recipeId = [].obs;
  List recipeNames = [].obs;

  List recipesIngredients = [].obs;
  List recipeImage = [].obs;
  List recipeInstructions = [].obs;
  List recipesUrl = [].obs;

  FavRecipeController() {
    favRecipeIds = RxList<RxInt>();
  }

  void addItem(int recipeId) {
    if (!favRecipeIds.any((id) => id.value == recipeId)) {
      favRecipeIds.add(recipeId.obs);
    }
  }

  void removeItem(int recipeId) {
    for (int i = 0; i < favRecipeIds.length; i++) {
      if (favRecipeIds[i].value == recipeId) {
        favRecipeIds.removeAt(i);
        break;
      }
    }
  }

  void addRecipeData({
    required int recipeId,
    required String recipeName,
    required String imageUrl,
    required String instructions,
    required List<String> ingredients,
  }) {
    // Add the passed data to the lists
    favRecipeIds.add(recipeId as RxInt);
    recipeNames.add(recipeName);
    recipesIngredients.add(ingredients);
    recipeImage.add(imageUrl);
    recipeInstructions.add(instructions);
  }

  Future<void> getRecipesByFavorites() async {
    // Clear existing recipe data
    recipeId.clear();
    recipeNames.clear();
    recipesIngredients.clear();
    recipeImage.clear();
    recipeInstructions.clear();
    recipesUrl.clear();

    // Fetch recipes from API
    String uri = 'https://dummyjson.com/recipes';
    try {
      var response = await http.get(Uri.parse(uri));
      Map temp = jsonDecode(response.body);
      isLoading.value = false;
      List allRecipes = temp['recipes'];

      // Filter recipes based on favorite recipe IDs
      allRecipes.forEach((recipe) {
        int id = recipe['id'];
        if (favRecipeIds.any((id) => id.value == recipeId)) {
          // Add recipe data
          recipeId.add(id.obs);
          recipeNames.add(recipe['name']);
          recipesIngredients.add(recipe['ingredients']);
          recipeImage.add(recipe['image']);
          recipeInstructions.add(recipe['instructions']);
          recipesUrl.add(recipe['image']);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
