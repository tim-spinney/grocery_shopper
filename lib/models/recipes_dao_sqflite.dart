

import 'recipes_dao.dart';
/*
class RecipesDaoSqflite implements RecipesDao {
  Database database;

  RecipesDaoSqflite(this.database);

  @override
  Future<int> addRecipe(Recipe recipe) async {
    final result = await database.insertRaw(
      "INSERT INTO recipes (...) VALUES (?, ?, ?, ?)",
      [recipe.name, recipe.description, recipe.foo, recipe.bar]
    );
    for(Ingredient i in recipe.ingredients) {
      database.insertRaw("INSERT INTO ingredients (recipeId, ...) VALUES")
    }
  }

  @override
  Future<void> deleteRecipe(int recipeId) {
    // TODO: implement deleteRecipe
    throw UnimplementedError();
  }

  @override
  Future<List<Recipe>> getRecipes() async {
    List<Map> results = await database.queryRaw("SELECT * FROM recipes");
    List<Recipe> recipes = results.map((map) => Recipe(...)).toList();
    return recipes;
  }

  Recipe _toRecipe(Map rawData) {}

}*/