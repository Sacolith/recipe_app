import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/provider/ingredient_provider.dart';
import 'package:recipe_app/provider/recipe_provider.dart';

class StaServ extends ChangeNotifier{
  final List<Recipe> _rec;
  final Box<Recipe> _recipeBox;

  StaServ(this._recipeBox) : _rec = RecProv.rec;

  List<Recipe> get allRecipies=>[
    ..._rec,
    // ignore: unnecessary_to_list_in_spreads
    ..._recipeBox.values.toList(),
  ];

Box<Recipe> get recipeBox=> _recipeBox;

  List<Recipe> searchRecipe(String? terms)=> allRecipies
  .where((t)=>t.title.toLowerCase().contains(terms!.toLowerCase()))
  .toList();
}

class IngredServ extends ChangeNotifier{
  final List<Ingredient> _ingred;
final Box<Ingredient> _ingredBox;

  IngredServ(this._ingredBox) :_ingred= Ipovider.ingred;

  List<Ingredient>get allIngreds=>[
    ...Ipovider.ingred,
    // ignore: unnecessary_to_list_in_spreads
    ..._ingredBox.values.toList(),
  ];
Box<Ingredient> get ingredientBox=> _ingredBox;

  List<Ingredient> searchIngredient(String? terms)=> allIngreds
  .where((t)=>t.name.toLowerCase().contains(terms!.toLowerCase()))
  .toList();
}