import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/state_service.dart';
import 'package:recipe_app/widget/container.dart';

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
    padding: const EdgeInsets.all(8),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
             child: Padding(
              padding: EdgeInsets.all(8),
              child: Text('Recipe not in database'),
                       ),
           ),
          TextButton(
            onPressed: () {
              // Add functionality to add a new recipe
            },
            child: const Text('Add new recipe?'),
          ),
        ],
      );
    }
   return ListView.builder(
    restorationId: 'list',
      itemCount: recipes.length+ 1,
      itemBuilder: (context, i) { if(i==0) 
         { return Visibility(
             visible: false,
             maintainSize: true,
             maintainAnimation: true,
             maintainState: true,
            child: _searchBox(active :false));
            } else{
              return Padding(padding: const EdgeInsets.all(8),
              child:  Reccont(rec: recipes[i-1]),);
            }
      },
    );
  }

     Widget _ingredientSearchResults(List<Ingredient> ingredients){
      if(ingredients.isEmpty){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
        itemCount: ingredients.length +1,
        itemBuilder: (context,i){
             if(i==0) 
         { return Visibility(
             visible: false,
             maintainSize: true,
             maintainAnimation: true,
             maintainState: true,
            child: _searchBox(active :false));
            } else{
              return Padding(padding: const EdgeInsets.all(8),
              child:  IngCon(ingredients: ingredients[i-1]),);
            }
        }
        );
    }

  @override
Widget build(BuildContext context) {
  final recipeModel = Provider.of<StaServ>(context);
  final ingredientModel = Provider.of<IngredServ>(context);

  return UnmanagedRestorationScope(
    child: CupertinoTabView(
      restorationScopeId: 'tabview',
      builder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          ),
          child: SafeArea(
            
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
                Expanded(
                  child: recipeSearch == Searchtype.recipes
                      ? Stack(
                          children: [
                            _recipeSearchResults(recipeModel.searchRecipe(terms)),
                            _searchBox(),
                          ],
                        )
                      : Stack(
                          children: [
                            _ingredientSearchResults(ingredientModel.searchIngredient(terms)),
                            _searchBox(),
                          ],
                        ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

}
enum Searchtype{ ingredients, recipes}