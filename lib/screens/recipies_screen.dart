import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/design/colors.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/recipe_service.dart';
import 'package:recipe_app/services/state_service.dart';

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
              child: _cardInfo(recipe),
            );
          },
          child: _buildCardWithSize(context, recipe),  // Pass context here
        ),
      ),
    );
  }

  Widget _buildCardWithSize(BuildContext context, Recipe recipe) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width * 0.5, // Adjust the size as needed
      child: _cardInfo(recipe),
    );
  }
}

Widget _cardInfo(Recipe recipe) {
  return Card(
    color: Cols.cyber_yellow,
    child: Padding(
      padding: const EdgeInsets.all(3.0),
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
