import 'package:recipe_app/models/ingredient.dart';
//Default local ingredient data
class Ipovider{
  static List<Ingredient> ingred=[
     Ingredient(
      name: 'Carrots',
      description: 'Orange,earthy vegatbles',
      ingredienttype: [IngredientType.vegetables], id: '0'
      )
  ];
}