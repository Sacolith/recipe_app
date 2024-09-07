

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipeService{
  final BuildContext context;
  final Box<Recipe> recipeBox;
  RecipeService({required this.context,required this.recipeBox});

   Future<void> addRecipe() async {
    String title = '';
    String description = '';
    String prepTime = '';
    String ingredients = '';
    RecipeType selectedType=RecipeType.dinner;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Recipe'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Prep Time'),
                onChanged: (value) => prepTime = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Ingredients'),
                onChanged: (value) => ingredients = value,
              ),
               DropdownButton<RecipeType>(
              value: selectedType,
              items: RecipeType.values.map((RecipeType type) {
                return DropdownMenuItem<RecipeType>(
                  value: type,
                  child: Text(type.toString().split('.').last), 
                );
              }).toList(),
              onChanged: (RecipeType? newValue) {
                if (newValue != null) {
                    selectedType = newValue; 
                  }
      }
      
          )
          ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newRecipe = Recipe(
                  id: DateTime.now().toString(),
                  title: title,
                  description: description,
                  prepTime: prepTime,
                  ingredients: ingredients,
                  recipetype: [selectedType],
                );
                recipeBox.add(newRecipe); 
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