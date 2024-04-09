import 'package:flutter/material.dart';
import 'package:grocery_shopper/new_shopping_item_form.dart';
import 'package:grocery_shopper/shopping_list.dart';
import 'grocery_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<GroceryItem> _shoppingList = [...sampleShoppingList];
  bool _isShowingAddForm = false;

  void _removeGroceryItem(GroceryItem item) {
    setState(() {
      _shoppingList.remove(item);
    });
  }

  void _addGroceryItem(GroceryItem item) {
    setState(() {
      _shoppingList.add(item);
    });
  }

  void _showAddForm() {
    setState(() {
      _isShowingAddForm = true;
    });
  }

  void _hideAddForm() {
    setState(() {
      _isShowingAddForm = false;
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
          Text('${_shoppingList.length}')
        ],
      ),
      body: Center(
        child: _isShowingAddForm
            ? NewShoppingItemForm(hideAddForm: _hideAddForm, addGroceryItem: _addGroceryItem,)
            : ShoppingList(
              groceryItems: _shoppingList,
              onDelete: _removeGroceryItem,
            )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddForm,
      ),
    );
  }
}
