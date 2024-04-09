import 'package:flutter/material.dart';
import 'grocery_item.dart';
import 'shopping_list_item.dart';

class ShoppingList extends StatelessWidget {
  final List<GroceryItem> groceryItems;

  final void Function(GroceryItem) onDelete;

  const ShoppingList({super.key, required this.groceryItems, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) =>
          ShoppingListItem(
            key: ValueKey(groceryItems[index]),
            groceryItem: groceryItems[index],
            onDelete: onDelete,
          ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'grocery_item.dart';

class ShoppingList extends StatelessWidget {
  final List<GroceryItem> groceryItems;
  const ShoppingList({super.key, required this.groceryItems});

  Widget _makeListTile(GroceryItem item) {
    final title = Text(item.name);
    final subtitle = Text(item.category);
    final trailing = Text('${item.quantity} ${item.unit.name}(s)');
    return ListTile(title: title, subtitle: subtitle, trailing: trailing,);
  }

  Widget _makeListItem(GroceryItem item) {
    Widget tile = _makeListTile(item);
    return Card(child: tile,);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for(int i = 0; i < groceryItems.length; i++) {
      children.add(_makeListItem(groceryItems[i]));
    }
    /*List<Widget> children = groceryItems.map((item) {
      return _makeListItem(item);
    }).toList();*/
    return ListView(
      children: children,
    );
  }
}

 */
