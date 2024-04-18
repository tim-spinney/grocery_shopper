
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'recipe.dart';
import '../recipes_dao.dart';

class RecipesDaoIsar implements RecipesDao {
  late Isar _database;

  RecipesDao() {
    _openDatabase();
  }

  _openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    _database = await Isar.open(
      [RecipeSchema],
      directory: dir.path,
    );
  }

  @override
  Future<int> addRecipe(Recipe recipe) {
    return _database.recipes.put(recipe);
  }

  @override
  Future<void> deleteRecipe(int recipeId) async {
    await _database.recipes.delete(recipeId);
  }

  @override
  Future<List<Recipe>> getRecipes() {
    return _database.recipes.where().findAll();
  }
}