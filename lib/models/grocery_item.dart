import 'item_base.dart';

class GroceryItem extends ItemBase {
  final String category;
  final int priceInCents;

  const GroceryItem({
    required super.name,
    required this.category,
    required super.quantity,
    required super.unit,
    this.priceInCents = 0
  });
}

const sampleShoppingList = [
  // We don't get a choice of stack vs. heap, so Dart just doesn't have "new" in its vocabulary. Everything goes on the heap and gets managed by the garbage collector.
  GroceryItem(
    quantity: 4,
    category: "Produce",
    unit: ItemUnit.each,
    name: "Bananas",
  ),
  GroceryItem(
    quantity: 12,
    category: "Dairy",
    unit: ItemUnit.each,
    name: "Eggs",
  ),
  GroceryItem(
    name: 'Milk, 2%',
    category: 'Dairy',
    quantity: 500,
    unit: ItemUnit.milliliter,
  )
];