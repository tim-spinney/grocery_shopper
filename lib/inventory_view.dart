import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/inventory.dart';
import 'inventory_location_view.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = context.select((Inventory inventory) => inventory.locations);
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations.elementAt(index);
        return Card(
          child: ExpansionTile(
            initiallyExpanded: true,
            key: PageStorageKey('expansion-$location'),
            title: Text(location),
            children: [
              const Divider(),
              InventoryLocationView(
                // We need this key here ore else the PageStorageKey for ExpansionTile will overwrite the scroll position with isExpanded
                key: PageStorageKey('location-$location'),
                location: location,
              ),
            ],
          ),
        );
      },
    );
  }
}