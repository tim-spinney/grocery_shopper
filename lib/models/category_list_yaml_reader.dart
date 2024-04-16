
import 'package:grocery_shopper/models/category_list.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart' show rootBundle;

class CategoryListYamlReader {
  Future<CategoryList> readCategoryList(String fileName) async {
    String fileContents = await rootBundle.loadString(fileName);
    YamlList data = loadYaml(fileContents);
    List<String> categories = [];
    data.forEach((e) => categories.add(e));
    return CategoryList(categories);
  }
}