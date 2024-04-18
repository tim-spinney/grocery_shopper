
import 'package:grocery_shopper/models/grocery_item.dart';
import 'package:isar/isar.dart';

part 'recipe.g.dart';

@collection
class Recipe {
  Id id = Isar.autoIncrement;

  String? title;
  int? servings;

  List<Ingredient>? ingredients;
}

@embedded
class Ingredient {
  String? name;
  int? amount;

  @enumerated
  ItemUnit unit = ItemUnit.Each;
}