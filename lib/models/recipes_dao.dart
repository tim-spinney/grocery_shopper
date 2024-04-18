import 'isar/recipe.dart';

abstract class RecipesDao {
  Future<List<Recipe>> getRecipes();

  Future<int> addRecipe(Recipe recipe);

  Future<void> deleteRecipe(int recipeId);


}