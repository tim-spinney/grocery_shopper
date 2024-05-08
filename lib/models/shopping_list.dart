
import 'package:flutter/cupertino.dart';

import 'grocery_item.dart';

class ShoppingList extends ChangeNotifier {
  final List<GroceryItem> _items = [];

  ShoppingList(Iterable<GroceryItem> items) {
    _items.addAll(items);
  }

  int get numItems => _items.length;

  GroceryItem operator[](int index) => _items[index];

  void addGroceryItem(GroceryItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeGroceryItem(GroceryItem item) {
    _items.remove(item);
    notifyListeners();
  }
}