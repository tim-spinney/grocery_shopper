
import 'package:flutter/cupertino.dart';

import 'grocery_item.dart';

class Recipe {
  final String name;
  final List<GroceryItem> items;

  Recipe(this.name, this.items);
}

class Recipes extends ChangeNotifier {
  final Map<String, Recipe> _recipes = {};

  Recipe? operator[](String name) => _recipes[name];

  Iterable<String> get recipeNames => _recipes.keys;

  void addRecipe(Recipe recipe) {
    _recipes[recipe.name] = recipe;
    notifyListeners();
  }
}