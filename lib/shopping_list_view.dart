import 'package:flutter/material.dart';
import 'package:grocery_shopper/models/shopping_list.dart';
import 'package:provider/provider.dart';
import 'shopping_list_item.dart';

class ShoppingListView extends StatelessWidget {

  const ShoppingListView({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingList = context.watch<ShoppingList>();
    return ListView.builder(
      itemCount: shoppingList.numItems,
      itemBuilder: (context, index) =>
        ShoppingListItem(
          groceryItemIndex: index,
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
