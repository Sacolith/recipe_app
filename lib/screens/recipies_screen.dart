import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/provider/recipe_provider.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeState();
}

class _RecipeState extends State<RecipeScreen> {
  late Box<Recipe> recipeBox;

  @override
  void initState() {
    super.initState();
    recipeBox = Hive.box<Recipe>('recipes'); 
  }

  Future<void> _addRecipe() async {
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
                  setState(() {
                    selectedType = newValue;
                  });
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
                setState(() {}); 
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final List<Recipe> allRecipes = [
      ...RecProv.rec, 
      // ignore: unnecessary_to_list_in_spreads
      ...recipeBox.values.toList() 
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: allRecipes.length,
        itemBuilder: (context, index) {
          final recipe = allRecipes[index];
          return GestureDetector(
            child: Hero(
              tag: 'recipe-card-${recipe.id}', 
              child: _cardInfo(recipe),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => R_Card(recipe: recipe),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecipe,
        tooltip: 'Add Recipe',
        child: const Icon(Icons.add),
      ),
    );
  }
}


// ignore: camel_case_types
class R_Card extends StatelessWidget {
  final Recipe recipe;

  const R_Card({required this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'recipe-card-${recipe.id}',  
          child: _cardInfo(recipe),
        ),
      ),
    );
  }
}


Widget _cardInfo(Recipe recipe) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(recipe.title, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text('Description: ${recipe.description}'),
          const SizedBox(height: 8),
          Text('Prep Time: ${recipe.prepTime}'),
        ],
      ),
    ),
  );
}
