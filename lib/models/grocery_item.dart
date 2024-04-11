enum ItemUnit {
  Gram,
  Mililiter,
  Each,
}

class GroceryItem {
  final String name;
  final String category;
  final int quantity;
  final ItemUnit unit;
  final int priceInCents;

  /*GroceryItem(
      this.name,
      this.category,
      this.quantity,
      this.unit,
      this.priceInCents
      );*/

  GroceryItem({
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    this.priceInCents = 0
  });
}

final sampleShoppingList = [
  // We don't get a choice of stack vs. heap, so Dart just doesn't have "new" in its vocabulary. Everything goes on the heap and gets managed by the garbage collector.
  GroceryItem(
    quantity: 4,
    category: "Produce",
    unit: ItemUnit.Each,
    name: "Bananas",
  ),
  GroceryItem(
    quantity: 12,
    category: "Dairy",
    unit: ItemUnit.Each,
    name: "Eggs",
  ),
  GroceryItem(
    name: 'Milk, 2%',
    category: 'Dairy',
    quantity: 500,
    unit: ItemUnit.Mililiter,
  )
];