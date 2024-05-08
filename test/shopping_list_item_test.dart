import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_shopper/models/grocery_item.dart';
import 'package:grocery_shopper/models/item_base.dart';
import 'package:grocery_shopper/models/shopping_list.dart';
import 'package:grocery_shopper/shopping_list_item.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'shopping_list_item_test.mocks.dart';
import 'widget_tester_helpers.dart';

@GenerateMocks([ShoppingList])
main() {
  testWidgets('displays the name, category, and quantity of the given grocery item', (tester) async {
    // setup/given/arrange
    const groceryItem = GroceryItem(
      name: 'Watermelon',
      category: 'Produce',
      quantity: 2500,
      unit: ItemUnit.gram,
    );

    final shoppingList = MockShoppingList();

    when(shoppingList[1]).thenReturn(groceryItem);

    // execution/when/act
    await tester.pumpWidgetWithMaterial(
        ChangeNotifierProvider<ShoppingList>.value(
          value: shoppingList,
          child: const ShoppingListItem(groceryItemIndex: 1,),
        )
    );

    // validation/then/assert
    expect(find.text(groceryItem.name), findsOneWidget);
    expect(find.text(groceryItem.category), findsOneWidget);
    expect(find.textContaining('${groceryItem.quantity}'), findsOneWidget);
  });

  testWidgets('does not display units when unit type is "Each"', (tester) async {
    // setup/given/arrange
    const groceryItem = GroceryItem(
      name: 'Banana',
      category: 'Produce',
      quantity: 6,
      unit: ItemUnit.each,
    );
    final shoppingList = MockShoppingList();

    when(shoppingList[0]).thenReturn(groceryItem);
    // execution/when/act
    await tester.pumpWidgetWithMaterial(
        ChangeNotifierProvider<ShoppingList>.value(
          value: shoppingList,
          child: const ShoppingListItem(groceryItemIndex: 0,),
        )
    );

    // validation/then/assert
    expect(find.textContaining(groceryItem.unit.name), findsNothing);
  });

  testWidgets('does display units when unit type is not "Each"', (tester) async {
    // setup/given/arrange
    const groceryItem = GroceryItem(
      name: 'Orange Juice',
      category: 'Beverages',
      quantity: 350,
      unit: ItemUnit.milliliter,
    );
    final shoppingList = MockShoppingList();

    when(shoppingList[0]).thenReturn(groceryItem);


    // execution/when/act
    await tester.pumpWidgetWithMaterial(
        ChangeNotifierProvider<ShoppingList>.value(
          value: shoppingList,
          child: const ShoppingListItem(groceryItemIndex: 0,),
        )
    );

    // validation/then/assert
    expect(find.textContaining(groceryItem.unit.name), findsOneWidget);
  });


  testWidgets('calls onDelete when the user taps the delete icon', (tester) async {
    const groceryItem = GroceryItem(
      name: 'Orange Juice',
      category: 'Beverages',
      quantity: 350,
      unit: ItemUnit.milliliter,
    );

    final shoppingList = MockShoppingList();

    when(shoppingList[99]).thenReturn(groceryItem);

    // execution/when/act
    await tester.pumpWidgetWithMaterial(ChangeNotifierProvider<ShoppingList>.value(
        value: shoppingList,
        child: const ShoppingListItem(groceryItemIndex: 99,),
      )
    );

    await tester.tap(find.byIcon(Icons.delete));

    verify(shoppingList.removeGroceryItem(groceryItem));
  });
}