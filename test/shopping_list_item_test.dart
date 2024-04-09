import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_shopper/grocery_item.dart';
import 'package:grocery_shopper/shopping_list_item.dart';

main() {
  testWidgets('displays the name, category, and quantity of the given grocery item', (tester) async {
    // setup/given/arrange
    final groceryItem = GroceryItem(
      name: 'Watermelon',
      category: 'Produce',
      quantity: 2500,
      unit: ItemUnit.Gram,
    );
    final onDelete = (GroceryItem _) {};

    // execution/when/act
    await tester.pumpWidget(
      MaterialApp(
          home: Scaffold(
            body: ShoppingListItem(groceryItem: groceryItem, onDelete: onDelete,
          ),
        ),
      )
    );

    // validation/then/assert
    expect(find.text(groceryItem.name), findsOneWidget);
    expect(find.text(groceryItem.category), findsOneWidget);
    expect(find.textContaining('${groceryItem.quantity}'), findsOneWidget);
  });
  
  testWidgets('does not display units when unit type is "Each"', (tester) async {
    // setup/given/arrange
    final groceryItem = GroceryItem(
      name: 'Banana',
      category: 'Produce',
      quantity: 6,
      unit: ItemUnit.Each,
    );
    final onDelete = (GroceryItem _) {};

    // execution/when/act
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShoppingListItem(groceryItem: groceryItem, onDelete: onDelete,
            ),
          ),
        )
    );

    // validation/then/assert
    expect(find.textContaining(groceryItem.unit.name), findsNothing);
  });

  testWidgets('does display units when unit type is not "Each"', (tester) async {
    // setup/given/arrange
    final groceryItem = GroceryItem(
      name: 'Orange Juice',
      category: 'Beverages',
      quantity: 350,
      unit: ItemUnit.Mililiter,
    );
    final onDelete = (GroceryItem _) {};

    // execution/when/act
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShoppingListItem(groceryItem: groceryItem, onDelete: onDelete,
            ),
          ),
        )
    );

    // validation/then/assert
    expect(find.textContaining(groceryItem.unit.name), findsOneWidget);
  });

  testWidgets('calls onDelete when the user taps the delete icon', (tester) async {
    final groceryItem = GroceryItem(
      name: 'Orange Juice',
      category: 'Beverages',
      quantity: 350,
      unit: ItemUnit.Mililiter,
    );
    bool wasCalled = false;
    final onDelete = (GroceryItem _) { wasCalled = true; };

    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShoppingListItem(groceryItem: groceryItem, onDelete: onDelete,
            ),
          ),
        )
    );

    await tester.tap(find.byIcon(Icons.delete));

    expect(wasCalled, true);
  });
}