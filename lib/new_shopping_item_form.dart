import 'package:flutter/material.dart';

class NewShoppingItemForm extends StatefulWidget {
  const NewShoppingItemForm({super.key});

  @override
  State<NewShoppingItemForm> createState() => _NewShoppingItemFormState();
}

class _NewShoppingItemFormState extends State<NewShoppingItemForm> {
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
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Category'
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Quantity'
              ),
              keyboardType: TextInputType.number,
            ),
            // TODO: dropdown for units
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Price'
              ),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {},
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
