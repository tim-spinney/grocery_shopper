import 'package:flutter/material.dart';
import 'package:grocery_shopper/models/shopping_list.dart';
import 'package:provider/provider.dart';
import 'models/grocery_item.dart';
import 'models/item_base.dart';

class ShoppingListItem extends StatelessWidget {
  final int groceryItemIndex;

  const ShoppingListItem({super.key, required this.groceryItemIndex});

  String _makeQuantitySuffix(GroceryItem groceryItem) {
    if(groceryItem.unit == ItemUnit.each) {
      return '';
    }
    return ' ${groceryItem.unit.name}(s)';
  }

  @override
  Widget build(BuildContext context) {
    final groceryItem = context.read<ShoppingList>()[groceryItemIndex];
    return Card(
      child: ListTile(
        title: Text(groceryItem.name),
        subtitle: Text(groceryItem.category),
        leading: Text(groceryItem.quantityWithUnitSuffix),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            context.read<ShoppingList>().removeGroceryItem(groceryItem);
          },
        ),
      ),
    );
  }
}