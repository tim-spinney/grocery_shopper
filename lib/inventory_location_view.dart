import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/inventory.dart';

class InventoryLocationView extends StatelessWidget {
  final String location;

  const InventoryLocationView({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final locationItems = context.select((Inventory inventory) => inventory.getItemsInLocation(location));
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: locationItems.map((item) {
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.quantityWithUnitSuffix),
        );
      }).toList(),
    );
  }
}
