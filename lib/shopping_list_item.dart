import 'package:flutter/material.dart';
import 'grocery_item.dart';

class ShoppingListItem extends StatelessWidget {
  final GroceryItem groceryItem;
  final void Function(GroceryItem) onDelete;

  const ShoppingListItem({super.key, required this.groceryItem, required this.onDelete});

  String _makeQuantitySuffix() {
    if(groceryItem.unit == ItemUnit.Each) {
      return '';
    }
    return ' ${groceryItem.unit.name}(s)';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(groceryItem.name),
        subtitle: Text(groceryItem.category),
        leading: Text('${groceryItem.quantity}${_makeQuantitySuffix()}'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            onDelete(groceryItem);
          },
        ),
      ),
    );
  }
}