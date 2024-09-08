import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/models/ingredient.dart';

class IngredientService with ChangeNotifier{
  final BuildContext context;
  final Box<Ingredient> ingredientBox;

  IngredientService({required this.context, required this.ingredientBox});

  Future<void> addIngredient() async {
    String name = '';
    String description = '';
    IngredientType selected = IngredientType.meats;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Ingredient'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
              ),
              DropdownButton<IngredientType>(
                value: selected,
                items: IngredientType.values.map((IngredientType type) {
                  return DropdownMenuItem<IngredientType>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (IngredientType? newValue) {
                  if (newValue != null) {
                    selected = newValue;
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newIngredient = Ingredient(
                  name: name,
                  description: description,
                  ingredienttype: [selected],
                  id: DateTime.now().toString(),
                );
                
                ingredientBox.add(newIngredient);
                notifyListeners();
                Navigator.of(context).pop();
                
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}



