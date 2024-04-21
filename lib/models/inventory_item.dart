import 'item_base.dart';

class InventoryItem extends ItemBase {
  final String location;

  const InventoryItem({
    required super.name,
    required this.location,
    required super.quantity,
    required super.unit,
  });
}

const sampleInventory = [
  InventoryItem(
    name: 'Bananas',
    location: 'Produce',
    quantity: 4,
    unit: ItemUnit.each,
  ),
  InventoryItem(
    name: 'Eggs',
    location: 'Dairy',
    quantity: 12,
    unit: ItemUnit.each,
  ),
  InventoryItem(
    name: 'Milk, 2%',
    location: 'Dairy',
    quantity: 500,
    unit: ItemUnit.milliliter,
  ),
];