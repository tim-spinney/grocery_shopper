import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/inventory_item.dart';
import 'models/inventory.dart';

enum _MenuAction {
  addToShoppingList,

}

class InventoryItemView extends StatelessWidget {
  final InventoryItem item;

  const InventoryItemView({super.key, required this.item});

  _removeItem(BuildContext context) {
    context.read<Inventory>().removeItem(item);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      leading: Text(item.quantityWithUnitSuffix),
      trailing: MenuAnchor(
        menuChildren: [
          MenuItemButton(
            onPressed: () { _removeItem(context); },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
        builder: (context, menuController, _) => IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            if(menuController.isOpen) {
              menuController.close();
            } else {
              menuController.open();
            }
          },
        )
      )
    );
  }
}
