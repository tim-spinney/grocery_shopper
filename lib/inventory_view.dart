import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shopper/inventory_item_view.dart';
import 'package:grocery_shopper/models/inventory_item.dart';
import 'package:provider/provider.dart';
import 'models/inventory.dart';
import 'inventory_location_view.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: readInventoryItems(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return const Text('Unable to read Cloud Firestore');
        } else if(snapshot.hasData) {
          final data = snapshot.data!;
          return ListView(
            children: data.map(
                    (item) => InventoryItemView(item: item)
            ).toList(),
          );
        }
        return const CircularProgressIndicator();
      }
    );
  }

  Stream<List<InventoryItem>> readInventoryItems() => FirebaseFirestore.instance
      .collection('inventory_items')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) =>
          InventoryItem.fromMap(doc.data())
      ).toList());
}