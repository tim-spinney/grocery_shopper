import 'package:flutter/material.dart';
import 'package:grocery_shopper/models/category_list.dart';
import 'package:grocery_shopper/models/grocery_item.dart';
import 'package:grocery_shopper/models/inventory.dart';
import 'package:grocery_shopper/models/shopping_list.dart';
import 'package:provider/provider.dart';

import 'models/inventory_item.dart';
import 'models/item_base.dart';

int _decimalMoneyToCents(String decimalMoney) {
  final decimalAmount = double.parse(decimalMoney);
  return (decimalAmount * 100).round();
}

class NewShoppingItemForm extends StatefulWidget {

  const NewShoppingItemForm({super.key});

  @override
  State<NewShoppingItemForm> createState() => _NewShoppingItemFormState();
}

class _NewShoppingItemFormState extends State<NewShoppingItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  ItemUnit? _itemUnit;
  String? _category;

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

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
            _NameField(_nameController),
            _CategoryField(_setCategory),
            _QuantityField(_quantityController),
            _UnitField(_itemUnit, _setItemUnit),
            _PriceField(_priceController),
            _ActionButtons(_onSave),
          ],
        )
      )
    );
  }
}

class _NameField extends StatelessWidget {
  final TextEditingController nameController;
  const _NameField(this.nameController);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Name'
      ),
      controller: nameController,
      validator: (value) {
        if(value == null || value.trim().isEmpty) {
          return 'Name cannot be empty.';
        }
        return null;
      },
    );
  }
}

String? _validateDropdownOption(String? option) {
  if (option == null) {
    return 'Select an option.';
  }
  return null;
}

class _CategoryField extends StatelessWidget {
  final void Function(String?) setCategory;
  const _CategoryField(this.setCategory);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: context.watch<CategoryList>().categories.map(
              (category) => DropdownMenuItem(
              value: category,
              child: Text(category)
          )
      ).toList(),
      onChanged: setCategory,
      validator: _validateDropdownOption,
    );
  }
}

class _QuantityField extends StatelessWidget {
  final TextEditingController quantityController;

  const _QuantityField(this.quantityController);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Quantity'
      ),
      keyboardType: TextInputType.number,
      controller: quantityController,
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
    );
  }
}

class _UnitField extends StatelessWidget {
  final ItemUnit? itemUnit;
  final void Function(ItemUnit?) setItemUnit;
  const _UnitField(this.itemUnit, this.setItemUnit);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: ItemUnit.values.map(
              (itemUnit) => DropdownMenuItem(
              value: itemUnit,
              child: Text(itemUnit.name)
          )
      ).toList(),
      value: itemUnit,
      onChanged: setItemUnit,
    );
  }
}

class _PriceField extends StatelessWidget {
  final TextEditingController priceController;

  const _PriceField(this.priceController);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Price'
      ),
      keyboardType: TextInputType.number,
      controller: priceController,
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
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final void Function() onSave;
  const _ActionButtons(this.onSave);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          onPressed: () { Navigator.pop(context); },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
