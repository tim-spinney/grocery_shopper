import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_shopper/models/inventory_item.dart';
import 'package:grocery_shopper/models/item_base.dart';
import 'package:mockito/mockito.dart';
import 'package:grocery_shopper/inventory_view.dart';
import 'package:grocery_shopper/models/inventory.dart';
import 'package:provider/provider.dart';
import 'inventory_location_view_test.mocks.dart';
import 'widget_tester_helpers.dart';

main() {
  testWidgets('displays each location in the provided Inventory', (tester) async {
    final inventory = MockInventory();
    when(inventory.locations).thenReturn(const ['left', 'right']);
    when(inventory.getItemsInLocation('left')).thenReturn(const [
      InventoryItem(name: 'Lentils', quantity: 250, unit: ItemUnit.gram, location: 'left'),
    ]);
    when(inventory.getItemsInLocation('right')).thenReturn(const []);

    await tester.pumpWidgetWithMaterial(
      ChangeNotifierProvider<Inventory>.value(
        value: inventory,
        child: const InventoryView(),
      ),
    );

    expect(find.text('left'), findsOneWidget);
    expect(find.text('right'), findsOneWidget);
    expect(find.text('Lentils'), findsOneWidget);
  });
}