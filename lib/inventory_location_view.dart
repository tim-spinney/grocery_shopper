import 'package:flutter/material.dart';
import 'inventory_item_view.dart';
import 'package:provider/provider.dart';

import 'models/inventory.dart';

class InventoryLocationView extends StatelessWidget {
  final String location;

  const InventoryLocationView({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final locationItems = context.watch<Inventory>().getItemsInLocation(location);
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: locationItems.map((item) => InventoryItemView(item: item,)).toList(),
    );
  }
}
