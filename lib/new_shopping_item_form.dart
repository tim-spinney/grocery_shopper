import 'package:flutter/material.dart';
import 'package:grocery_shopper/models/category_list.dart';
import 'package:grocery_shopper/models/grocery_item.dart';
import 'package:grocery_shopper/models/shopping_list.dart';
import 'package:provider/provider.dart';

class NewShoppingItemForm extends StatefulWidget {

  const NewShoppingItemForm({super.key});

  @override
  State<NewShoppingItemForm> createState() => _NewShoppingItemFormState();
}

int _decimalMoneyToCents(String decimalMoney) {
  final decimalAmount = double.parse(decimalMoney);
  return (decimalAmount * 100).round();
}

class _NewShoppingItemFormState extends State<NewShoppingItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();

  final _priceController = TextEditingController();

  ItemUnit? _itemUnit;

  String? _category;

  void _setItemUnit(ItemUnit? itemUnit) {
    setState(() {
      _itemUnit = itemUnit;
    });
  }

  void _setCategory(String? category) {
    setState(() {
      _category = category;
    });
  }

  void _onSave() {
    if(_formKey.currentState?.validate() ?? false) {
      final newGroceryItem = GroceryItem(
        name: _nameController.text,
        category: _category!,
        quantity: int.parse(_quantityController.text),
        unit: _itemUnit!,
        // TODO: deal with possibility of null
        priceInCents: _decimalMoneyToCents(_priceController.text),
      );
      context.read<ShoppingList>().addGroceryItem(newGroceryItem);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${_nameController.text} added to shopping list.')
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name'
              ),
              controller: _nameController,
              validator: (value) {
                if(value == null || value.trim().isEmpty) {
                  return 'Name cannot be empty.';
                }
                return null;
              },
            ),
            DropdownButtonFormField(
              items: context.watch<CategoryList>().categories.map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category)
                    )
              ).toList(),
              onChanged: _setCategory,
              validator: (category) {
                if(category == null) {
                  return 'Select a category.';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Quantity'
              ),
              keyboardType: TextInputType.number,
              controller: _quantityController,
              validator: (value) {
                if(value == null || value.trim().isEmpty) {
                  return 'Quantity cannot be empty.';
                }
                int? asInt = int.tryParse(value);
                if(asInt == null) {
                  return 'Quantity must be a whole number.';
                }
                if(asInt <= 0) {
                  return 'Quantity must be positive.';
                }
                return null;
              },
            ),
            DropdownButton(
              items: ItemUnit.values.map(
                      (itemUnit) => DropdownMenuItem(
                        value: itemUnit,
                        child: Text(itemUnit.name)
                      )
              ).toList(),
              value: _itemUnit,
              onChanged: _setItemUnit,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Price'
              ),
              keyboardType: TextInputType.number,
              controller: _priceController,
              validator: (value) {
                if(value == null || value.trim().isEmpty) {
                  return 'Quantity cannot be empty.';
                }
                double? asDouble = double.tryParse(value);
                if(asDouble == null) {
                  return 'Quantity must be a whole number.';
                }
                if(asDouble <= 0) {
                  return 'Quantity must be positive.';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () { Navigator.pop(context); },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Save'),
                ),
              ],
            )

          ],
        )
      )
    );
  }
}
