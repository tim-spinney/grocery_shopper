import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_shopper/inventory_item_view.dart';
import 'package:grocery_shopper/models/inventory.dart';
import 'package:grocery_shopper/models/inventory_item.dart';
import 'package:grocery_shopper/models/item_base.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'inventory_location_view_test.mocks.dart';
import 'widget_tester_helpers.dart';

main() {
  testWidgets('InventoryItemView displays item details', (WidgetTester tester) async {
    await tester.pumpWidgetWithMaterial(
      const InventoryItemView(
        item: InventoryItem(
          name: 'Apples',
          quantity: 2000,
          unit: ItemUnit.gram,
          location: 'Pantry'
        ),
      ),
    );

    expect(find.text('Apples'), findsOneWidget);
    expect(find.text('2000 gram(s)'), findsOneWidget);
  });

  testWidgets('InventoryItemView remove item', (WidgetTester tester) async {
    const item = InventoryItem(
      name: 'Apples',
      quantity: 2000,
      unit: ItemUnit.gram,
      location: 'Pantry',
    );
    final inventory = MockInventory();
    when(inventory.removeItem(item)).thenAnswer((_) {});

    await tester.pumpWidgetWithMaterial(
      ChangeNotifierProvider<Inventory>.value(
        value: inventory,
        child: const InventoryItemView(item: item)
      )
    );

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pump();
    await tester.tap(find.text('Remove'));
    await tester.pump();

    verify(inventory.removeItem(item));
  });
}
