import 'package:flutter/material.dart';
import 'package:grocery_shopper/models/recipes.dart';
import 'package:grocery_shopper/models/shopping_list.dart';
import 'package:grocery_shopper/new_shopping_item_form.dart';
import 'package:grocery_shopper/shopping_list_view.dart';
import 'package:provider/provider.dart';
import 'models/grocery_item.dart';

void main() {
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
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
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
  bool _isShowingAddForm = false;

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
          Text('${context.watch<ShoppingList>().numItems}'),
          const SizedBox(width: 8,)
        ],
      ),
      body: Center(
        child: _isShowingAddForm
            ? NewShoppingItemForm(hideAddForm: _hideAddForm)
            : const ShoppingListView()
      ),
      floatingActionButton: _isShowingAddForm ? null : FloatingActionButton(
        onPressed: _showAddForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
