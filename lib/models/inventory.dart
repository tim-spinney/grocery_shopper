import 'package:flutter/foundation.dart';
import 'inventory_item.dart';

class Inventory extends ChangeNotifier {
  final Map<String, List<InventoryItem>> _itemsByLocation = {};

  Inventory(List<InventoryItem> items) {
    for(final item in items) {
      _itemsByLocation.putIfAbsent(item.location, () => []).add(item);
    }
  }

  Iterable<String> get locations => _itemsByLocation.keys;

  List<InventoryItem> getItemsInLocation(String location) => _itemsByLocation[location] ?? [];

  void removeItem(InventoryItem item) {
    final items = _itemsByLocation[item.location];
    if(items != null) {
      items.remove(item);
      notifyListeners();
    }
  }
}