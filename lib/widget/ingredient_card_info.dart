import 'package:flutter/material.dart';
import 'package:recipe_app/design/colors.dart';
import 'package:recipe_app/models/ingredient.dart';

class IngredientCardInfo extends StatelessWidget{
  final Ingredient ingredient;
  const IngredientCardInfo({
    super.key,required this.ingredient
  });

  @override
  Widget build(BuildContext context){
    return Card(
    color: Cols.cyber_yellow,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ingredient.name, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 8),
          Text('Description: ${ingredient.description}',style: const TextStyle(fontSize: 20),),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
  }
}