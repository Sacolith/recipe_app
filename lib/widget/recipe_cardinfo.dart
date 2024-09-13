import 'package:flutter/material.dart';
import 'package:recipe_app/design/colors.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipeCardinfo extends StatelessWidget{
  final Recipe recipe;
  const RecipeCardinfo({super.key,required this.recipe});
  @override
  Widget build(BuildContext context){
    return Card(
    color: Cols.cyber_yellow,
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(recipe.title, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 8),
          Text('Description: ${recipe.description}',style: const TextStyle(fontSize: 20),),
          const SizedBox(height: 8),
          Text('Prep Time: ${recipe.prepTime}', style: const TextStyle(fontSize: 17),),
        ],
      ),
    ),
  );
  }
}