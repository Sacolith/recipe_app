import 'package:flutter/material.dart';
import 'package:recipe_app/provider/ingredient_provider.dart';
import 'package:recipe_app/provider/recipe_provider.dart';
import 'package:recipe_app/screens/ingredients_screen.dart';
import 'package:recipe_app/screens/recipies_screen.dart';
import 'package:recipe_app/widget/segbutton.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({
    super.key
  });

  @override
  State<HomeScreen> createState()=> _HomeState();
}

class _HomeState extends State<HomeScreen>{  
  late List rec;
  late List ing;
  Searchtype changeDisplay= Searchtype.recipes;
 

@override
void initState(){
  super.initState();
  rec=RecProv.rec;
  ing=Ipovider.ingred;
}
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
         Segbutton(selectedSearchType: changeDisplay,
          onSelectionChanged: (Searchtype newtype){
            setState(() {
              changeDisplay=newtype;
            });
          })
      ],) ,
      
body: changeDisplay== Searchtype.recipes
  ?const Stack(
    children: [
      RecipeScreen()
    ],
  )
  : const Stack(
    children: [
      IngredientsScreen()
    ],)
    );
  }
}
