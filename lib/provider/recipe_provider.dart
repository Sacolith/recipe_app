import 'package:recipe_app/models/recipe.dart';
//Default local recipedata
class RecProv{
static List<Recipe> rec=[
  //you can inclued n image data type in the model if you want a visual of the dish
 const Recipe(
    id: '0',
   title: 'Chicken alfredo Pasta', 
   description: 'A Simple Meal to enjoy with friends and family', 
  prepTime: '40 minutes', 
  ingredients: '',
   recipetype: [RecipeType.dinner])
];
}