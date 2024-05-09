import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'models/shopping_list.dart';
import 'new_item_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const newItemDialogs = {
  '/shoppingList': NewShoppingItemForm(),
  '/inventory': NewInventoryItemForm(),
};


class AppScaffold extends StatelessWidget {
  final String path;
  final Widget child;
  const AppScaffold({super.key, required this.path, required this.child});

  void _showAddForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog.fullscreen(
          child: newItemDialogs[path]!,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(AppLocalizations.of(context)!.groceryShopper),
          actions: [
            const Icon(Icons.shopping_cart_outlined),
            Text('${context.watch<ShoppingList>().numItems}'),
            const SizedBox(width: 8,)
          ],
        ),
        body: Center(
          child: child,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () { _showAddForm(context); },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Shopping List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shelves),
              label: 'Inventory',
            ),
          ],
          currentIndex: path == '/shoppingList' ? 0 : 1,
          onTap: (index) {
            if(index == 0) {
              context.go('/shoppingList');
            } else {
              context.go('/inventory');
            }
          },
        )
    );
  }
}