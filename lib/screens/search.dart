import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/ingredients_screen.dart';
import 'package:recipe_app/screens/recipies_screen.dart';
import 'package:recipe_app/services/ingredient_service.dart';
import 'package:recipe_app/services/recipe_service.dart';
import 'package:recipe_app/services/state_service.dart';
import 'package:recipe_app/widget/ingredient_card_info.dart';
import 'package:recipe_app/widget/recipe_cardinfo.dart';
import 'package:recipe_app/widget/segbutton.dart';

// this projects search features was influenced by flutter sample: https://github.com/flutter/samples/tree/master_archived/veggieseasons
class Search extends StatefulWidget {
  const Search({super.key, this.restID});

  final String? restID;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with RestorationMixin {
  final searchtext = RestorableTextEditingController();
  final focusN = FocusNode();
  String? terms;
  Searchtype recipeSearch = Searchtype.recipes;

  @override
  String? get restorationId => widget.restID;

  @override
  void restoreState(RestorationBucket? oldbucket, bool initialRestore) {
    registerForRestoration(searchtext, 'text');
    searchtext.addListener(_searched);
    terms = searchtext.value.text;
  }

  @override
  void dispose() {
    focusN.dispose();
    searchtext.dispose();
    super.dispose();
  }

  void _searched() {
    final newTerms = searchtext.value.text;
    if (terms != newTerms) {
      setState(() => terms = newTerms);
    }
  }

 Widget _searchBox({bool active = true}) {
  return Padding(
    padding: const EdgeInsets.all(1),
    child: Material(
      child: TextField(
        controller: searchtext.value,
        focusNode: active ? focusN : null,
        
      ),
    ),
  );
}

  Widget _recipeSearchResults(List<Recipe> recipes) {
   final recMod=Provider.of<StaServ>(context);
   final recServ= RecipeService(context: context,
    recipeBox: recMod.recipeBox);
    if (recipes.isEmpty) {
      return Column(
        children: [
          const Center(
             child: Padding(
              padding: EdgeInsets.all(8),
              child: Text('Recipe not in database'),
                       ),
           ),
          TextButton(
            onPressed: () async {
              recServ.addRecipe();
              setState(() {
              });
            },
            child: const Text('Add new recipe?'),
          ),
        ],
      );
    }
   return ListView.builder(
    restorationId: 'list',
      itemCount: recipes.length,
    itemBuilder: (context, index) {
      final recipe = recipes[index];
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
  );
  }


     Widget _ingredientSearchResults(List<Ingredient> ingredients){
      final ingreMod= Provider.of<IngredServ>(context);
      final ingredService=IngredientService(
      context: context,
      ingredientBox: ingreMod.ingredientBox
      );
      if(ingredients.isEmpty){
        return Column(
          children: [
           const Center(
             child: Padding(padding: EdgeInsets.all(8),
              child: Text('Ingredient not in database'),
              ),
           ),
            TextButton(onPressed: ()async{
               await ingredService.addIngredient();
               setState(() {
                 
               });
            }, child: const Text('Add ingredient'))
          ],
        );
      }
      return ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context,i){
           final ingredient= ingredients[i];
           return GestureDetector(
            child: Hero(
              tag: 'Ingredient-card-${ingredient.id}',
             child: IngredientCardInfo(ingredient:ingredient),
              ),
              onTap: ()=> Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=> I_Card(ingredient: ingredient) )
              ),
           );
        }
        );
    }
  @override
Widget build(BuildContext context) {
  final recipeModel = Provider.of<StaServ>(context);
  final ingredientModel = Provider.of<IngredServ>(context);
 final recipeservice=RecipeService(
    context: context,
    recipeBox: recipeModel.recipeBox
     );

     final ingredientservice=IngredientService(
      context: context,
      ingredientBox: ingredientModel.ingredientBox
      );
  return Scaffold(
    appBar: AppBar(
      title: const Text('Search'),
     actions: [
       Segbutton(
         selectedSearchType: recipeSearch,
          onSelectionChanged: (Searchtype newType) {
            setState(() {
              recipeSearch = newType;
            });
          },
       )
     ],
    ),
    body: Column(
      children: [
        _searchBox(),
        Expanded(
            child: recipeSearch == Searchtype.recipes
                ? _recipeSearchResults(recipeModel.searchRecipe(terms))
                : _ingredientSearchResults(ingredientModel.searchIngredient(terms)),
          ),
         
      ],
      
    ),
    floatingActionButton: recipeSearch == Searchtype.recipes
          ? FloatingActionButton(
              onPressed: () async {
                await recipeservice.addRecipe();
                setState(() {}); // Rebuild the screen to display the new recipe
              },
              tooltip: 'Add Recipe',
              child: const Icon(Icons.add),
            ): 
            FloatingActionButton(onPressed: ()async{
              await ingredientservice.addIngredient();
              setState(() {
                
              });
            },
            tooltip: 'Add Ingredient',
            child: const Icon(Icons.add),
            ),
  );
}
}
