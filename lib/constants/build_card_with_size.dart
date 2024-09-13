import 'package:flutter/material.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/widget/ingredient_card_info.dart';
import 'package:recipe_app/widget/recipe_cardinfo.dart';

Widget buildCardWithSizeIngred(BuildContext context, Ingredient ingredient) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width * 0.5, 
      child: IngredientCardInfo(ingredient:ingredient),
    );
  }

   Widget buildCardWithSizeRec(BuildContext context, Recipe recipe) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width * 0.5,
      child: RecipeCardinfo(recipe:recipe),
    );
  }
