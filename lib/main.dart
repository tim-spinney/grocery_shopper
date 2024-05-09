import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_shopper/app_scaffold.dart';
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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/shoppingList',
  routes: [
    ShellRoute(
      builder: (context, state, child) =>
        AppScaffold(path: state.fullPath!, child: child),
      routes: [
        GoRoute(
          path: '/shoppingList',
          builder: (context, state) => const ShoppingListView(),
        ),
        GoRoute(
          path: '/inventory',
          builder: (context, state) => const InventoryView(),
        ),
      ],
    ),
  ]
);

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
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('es'), // Spanish
          ],
        ),
      ),
    );
  }
}
