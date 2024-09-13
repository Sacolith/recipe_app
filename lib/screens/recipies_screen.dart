import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/constants/build_card_with_size.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/recipe_service.dart';
import 'package:recipe_app/services/state_service.dart';
import 'package:recipe_app/widget/recipe_cardinfo.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeState();
}

class _RecipeState extends State<RecipeScreen> {
 
final Box<Recipe> rBoxinstance= Hive.box<Recipe>('recipies');


  @override
  Widget build(BuildContext context) {
    final StaServ serv=StaServ(rBoxinstance);

    final List<Recipe> allRecipes = serv.allRecipies;
    final RecipeService recipeService= RecipeService(
      context: context, 
      recipeBox: rBoxinstance);
    
    return Scaffold(
      body: ListView.builder(
        itemCount: allRecipes.length,
        itemBuilder: (context, index) {
          final recipe = allRecipes[index];
          return GestureDetector(
            child: Hero(
              tag: 'recipe-card-${recipe.id}', 
              child: RecipeCardinfo(recipe:recipe),
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
        onPressed: ()async{
           await recipeService.addRecipe();
          setState(() {});
        },
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
          flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
            return ScaleTransition(
              scale: animation.drive(Tween<double>(begin: 1.0, end: 1.1).chain(CurveTween(curve: Curves.easeInOut))),
              child: RecipeCardinfo(recipe:recipe),
            );
          },
          child: buildCardWithSizeRec(context, recipe),
        ),
      ),
    );
  }

}

