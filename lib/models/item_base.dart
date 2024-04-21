enum ItemUnit {
  gram,
  milliliter,
  each,
}

class ItemBase {
  final String name;
  final int quantity;
  final ItemUnit unit;

  const ItemBase({required this.name, required this.quantity, required this.unit});

  String get quantityWithUnitSuffix {
    if(unit == ItemUnit.each) {
      return '$quantity';
    }
    return '$quantity ${unit.name}(s)';
  }
}