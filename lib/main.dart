import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/category_list_yaml_reader.dart';
import 'models/inventory_item.dart';
import 'models/recipes.dart';
import 'models/shopping_list.dart';
import 'models/grocery_item.dart';
import 'models/inventory.dart';
import 'new_shopping_item_form.dart';
import 'shopping_list_view.dart';
import 'category_list_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ShoppingList(sampleShoppingList)
        ),
        ChangeNotifierProvider.value(
          value: Recipes()
        ),
        ChangeNotifierProvider.value(
          value: Inventory(sampleInventory)
        )
      ],
      child: CategoryListProvider(
        reader: CategoryListYamlReader(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showAddForm() {
    setState(() {
      showDialog(
        context: context,
        builder: (context) => const Dialog.fullscreen(
          child: NewShoppingItemForm(),
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Grocery Shopper"),
        actions: [
          const Icon(Icons.shopping_cart_outlined),
          Text('${context.watch<ShoppingList>().numItems}'),
          const SizedBox(width: 8,)
        ],
      ),
      body: const Center(
        child: ShoppingListView()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
