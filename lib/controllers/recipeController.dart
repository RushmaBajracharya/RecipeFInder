import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class RecipeController extends GetxController {
//   var recipes = <Recipes>[].obs;
//   String uri = 'https://dummyjson.com/recipes';

//   Future<void> fetchRecipes() async {
//     final response = await http.get(Uri.parse(uri));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       final recipeObject = recipe.fromJson({'recipes': data});
//       recipes.value = recipeObject.recipes ?? [];
//     } else {
//       throw Exception('Failed to load recipes');
//     }
//   }

//   ///
// }

// class RecipeController extends GetxController {
//   var RecipeList = RxList<RecipeModel>();

//   @override
//   void onInit() {
//     super.onInit();
//     getRecipes();
//   }

//   Future<RxList<RecipeModel>> getRecipes() async {
//     final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));
//     var data = jsonDecode(response.body.toString());

//     if (response.statusCode == 200) {
//       for (Map<String, dynamic> index in data) {
//         RecipeList.add(RecipeModel.fromJson(index));
//       }
//       return RecipeList;
//     } else {
//       return RecipeList;
//     }
//   }
// }

class RecipeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getRecipes();
  }

  RxBool isLoading = true.obs;
  String jsonString = '';
  List recipes = [].obs;

  List recipeNames = [].obs;

  List recipesIngredients = [].obs;
  List recipeImage = [].obs;
  List recipeInstructions = [].obs;
  List recipesUrl = [].obs;
  var favoriteStatus = <bool>[].obs;

  Future<void> getRecipes() async {
    String uri = 'https://dummyjson.com/recipes';
    try {
      var response = await http.get(Uri.parse(uri));
      Map temp = jsonDecode(response.body);
      isLoading.value = false;
      recipes = temp['recipes'];

      recipeNames = recipes.map((recipe) => recipe['name']).toList();

      recipesIngredients =
          recipes.map((recipe) => recipe['ingredients']).toList();

      recipeInstructions =
          recipes.map((recipe) => recipe['instructions']).toList();
      recipesUrl = recipes.map((recipe) => recipe['image']).toList();
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Function to toggle favorite status
  void toggleFavoriteStatus(int index) {
    favoriteStatus[index] = !favoriteStatus[index];
    update();
  }
}
