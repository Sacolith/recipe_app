import 'package:flutter/material.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';

class Reccont extends StatelessWidget{
  final Recipe rec;

const Reccont({
  required this.rec,super.key
});
List<Widget> _buildrecipeDots(List<RecipeType> recipetype){
  var widgets = <Widget>[];
  for(var recipetypes in recipetype ){
    widgets.add(const SizedBox(width: 4,));
    widgets.add(
      Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
        ),
      )
    );
  }
  return widgets;
}

@override
Widget build(BuildContext context){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        const SizedBox(width: 8),
        Flexible(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  rec.title
                ),..._buildrecipeDots(rec.recipetype)
              ],
            ),
        Text(rec.description),
          ],
        )
        )
    ],
    );
}
}

class IngCon extends StatelessWidget{
  final Ingredient ingredients;
  const IngCon({
    required this.ingredients,super.key
  });
List<Widget> _buildIngredientDots(List<IngredientType> ingredtype){
  var widgets = <Widget>[];
  for(var ingred in ingredtype ){
    widgets.add(const SizedBox(width: 4,));
    widgets.add(
      Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
        ),
      )
    );
  }
  return widgets;
}

@override
Widget build(BuildContext context){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        const SizedBox(width: 8),
        Flexible(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  ingredients.name
                ),..._buildIngredientDots(ingredients.ingredienttype)
              ],
            ),
        Text(ingredients.description),
          ],
        )
        )
    ],
    );
}



}