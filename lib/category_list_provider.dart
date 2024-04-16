import 'package:flutter/material.dart';
import 'package:grocery_shopper/main.dart';
import 'package:grocery_shopper/models/category_list_yaml_reader.dart';
import 'package:provider/provider.dart';

import 'models/category_list.dart';

class CategoryListProvider extends StatelessWidget {
  final CategoryListYamlReader reader;
  final Widget child;

  const CategoryListProvider({super.key, required this.reader, required this.child});

  @override
  Widget build(BuildContext context) {
    final futureCategories = reader.readCategoryList('assets/categories.yaml');
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return Provider.value(
            value: snapshot.data!,
            child: child,
          );
          // TODO: handle failure case
        }
        return const CircularProgressIndicator();
      }
    );
  }
}
