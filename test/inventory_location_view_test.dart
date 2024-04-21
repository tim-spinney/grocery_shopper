import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_shopper/inventory_location_view.dart';
import 'package:grocery_shopper/models/inventory.dart';
import 'package:grocery_shopper/models/inventory_item.dart';
import 'package:grocery_shopper/models/item_base.dart';
import 'package:provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'inventory_location_view_test.mocks.dart';
import 'widget_tester_helpers.dart';

@GenerateMocks([Inventory])
main() {
  testWidgets('gets and displays items for given location', (WidgetTester tester) async {
    final inventory = MockInventory();
    const location = 'Cabinet below where we keep the dishes';
    when(inventory.getItemsInLocation(location)).thenReturn(const [
      InventoryItem(name: 'Lentils', quantity: 250, unit: ItemUnit.gram, location: location),
    ]);
    await tester.pumpWidgetWithMaterial(
      ChangeNotifierProvider<Inventory>.value(
        value: inventory,
        child: const InventoryLocationView(location: location),
      ),
    );

    expect(find.text('Lentils'), findsOneWidget);
  });
}