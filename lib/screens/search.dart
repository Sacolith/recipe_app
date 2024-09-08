import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/ingredients_screen.dart';
import 'package:recipe_app/screens/recipies_screen.dart';
import 'package:recipe_app/services/ingredient_service.dart';
import 'package:recipe_app/services/recipe_service.dart';
import 'package:recipe_app/services/state_service.dart';

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
          child: _cardInfo(recipe),
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

Widget _cardInfo(Recipe recipe) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
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

     Widget _ingredientSearchResults(List<Ingredient> ingredients){
      if(ingredients.isEmpty){
        return Column(
          children: [
           const Center(
             child: Padding(padding: EdgeInsets.all(8),
              child: Text('Ingredient not in database'),
              ),
           ),
            TextButton(onPressed: (){
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
             child: _ingredientCards(ingredient),
              ),
              onTap: ()=> Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=> I_Card(ingredient: ingredient) )
              ),
           );
        }
        );
    }

Widget _ingredientCards(Ingredient ingredient){
  return Card(
    child: Padding(padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ingredient.name, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text('Description: ${ingredient.description}'),
          const SizedBox(height: 8),
      ],
    ),
    ),
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
     
    ),
    body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          SegmentedButton<Searchtype>(
            style: SegmentedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.red,
              selectedForegroundColor: Colors.white,
              selectedBackgroundColor: Colors.green,
            ),
            segments: const <ButtonSegment<Searchtype>>[
              ButtonSegment<Searchtype>(
                value: Searchtype.recipes,
                label: Text('Recipes'),
                icon: Icon(Icons.receipt_outlined),
              ),
              ButtonSegment<Searchtype>(
                value: Searchtype.ingredients,
                label: Text('Ingredients'),
                icon: Icon(Icons.food_bank),
              ),
            ],
            selected: <Searchtype>{recipeSearch},
            onSelectionChanged: (Set<Searchtype> newSelection) {
              setState(() {
                recipeSearch = newSelection.first;
              });
            },
          ),
          _searchBox(),
          Expanded(
            child: recipeSearch == Searchtype.recipes
                ? _recipeSearchResults(recipeModel.searchRecipe(terms))
                : _ingredientSearchResults(ingredientModel.searchIngredient(terms)),
          ),
        ],
      ),
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
            })
  );
}
}
enum Searchtype{ ingredients, recipes}