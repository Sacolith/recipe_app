import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/provider/ingredient_provider.dart';
import 'package:recipe_app/provider/recipe_provider.dart';

class StaServ extends ChangeNotifier{
  final List<Recipe> _rec;

  StaServ() : _rec = RecProv.rec;

  List<Recipe> searchRecipe(String? terms)=> _rec
  .where((t)=>t.title.toLowerCase().contains(terms!.toLowerCase())).toList();
}

class IngredServ extends ChangeNotifier{

  final List<Ingredient> _ingred;
  IngredServ() :_ingred= Ipovider.ingred;

  List<Ingredient> searchIngredient(String? terms)=> _ingred.where((t)=>t.name.toLowerCase().contains(terms!.toLowerCase())).toList();
}