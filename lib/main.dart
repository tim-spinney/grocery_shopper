import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/category_list_yaml_reader.dart';
import 'models/inventory_item.dart';
import 'models/recipes.dart';
import 'models/shopping_list.dart';
import 'models/grocery_item.dart';
import 'models/inventory.dart';
import 'inventory_view.dart';
import 'new_item_forms.dart';
import 'shopping_list_view.dart';
import 'category_list_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

enum _Page {
  shoppingList,
  inventory,
}

const pageWidgets = {
  _Page.shoppingList: ShoppingListView(),
  _Page.inventory: InventoryView(),
};

const newItemDialogs = {
  _Page.shoppingList: NewShoppingItemForm(),
  _Page.inventory: NewInventoryItemForm(),
};

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _Page _currentPage = _Page.shoppingList;

  void _showAddForm() {
    setState(() {
      showDialog(
        context: context,
        builder: (context) => Dialog.fullscreen(
          child: newItemDialogs[_currentPage]!,
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
      body: Center(
        child: pageWidgets[_currentPage],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddForm,
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
        currentIndex: _currentPage.index,
        onTap: (index) {
          setState(() {
            _currentPage = _Page.values[index];
          });
        },
      )
    );
  }
}
