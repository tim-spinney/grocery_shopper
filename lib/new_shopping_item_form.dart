import 'package:flutter/material.dart';
import 'package:grocery_shopper/grocery_item.dart';

class NewShoppingItemForm extends StatefulWidget {
  final void Function() hideAddForm;
  final void Function(GroceryItem) addGroceryItem;

  const NewShoppingItemForm({super.key, required this.hideAddForm, required this.addGroceryItem});

  @override
  State<NewShoppingItemForm> createState() => _NewShoppingItemFormState();
}

int _decimalMoneyToCents(String decimalMoney) {
  final decimalAmount = double.parse(decimalMoney);
  return (decimalAmount * 100).round();
}

class _NewShoppingItemFormState extends State<NewShoppingItemForm> {
  ItemUnit? _itemUnit;
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _quantityController = TextEditingController();

  final _priceController = TextEditingController();

  void _setItemUnit(ItemUnit? itemUnit) {
    print(itemUnit);
    setState(() {
      _itemUnit = itemUnit;
    });
  }

  void _onSave() {
    final newGroceryItem = GroceryItem(
      name: _nameController.text,
      category: _categoryController.text,
      quantity: int.parse(_quantityController.text),
      unit: _itemUnit!, // TODO: deal with possibility of null
      priceInCents: _decimalMoneyToCents(_priceController.text),
    );

    widget.addGroceryItem(newGroceryItem);
    widget.hideAddForm();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name'
              ),
              controller: _nameController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Category'
              ),
              controller: _categoryController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Quantity'
              ),
              keyboardType: TextInputType.number,
              controller: _quantityController,
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: widget.hideAddForm,
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
