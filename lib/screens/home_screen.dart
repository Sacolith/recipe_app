import 'package:flutter/material.dart';
import 'package:recipe_app/provider/ingredient_provider.dart';
import 'package:recipe_app/provider/recipe_provider.dart';
import 'package:recipe_app/screens/ingredients_screen.dart';
import 'package:recipe_app/screens/recipies_screen.dart';

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
  LType changeDisplay=LType.recipies;
 

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
         SegmentedButton<LType>(
          segments: const<ButtonSegment<LType>>[
          ButtonSegment<LType>(
            value: LType.recipies,
            label: Text('Recipies'),
            icon: Icon(Icons.receipt)
          ),
          ButtonSegment<LType>(
            value: LType.ingredients,
            label: Text('Ingredients'),
            icon: Icon(Icons.food_bank) 
             ),
         ],
          selected: <LType>{changeDisplay},
         onSelectionChanged: (Set<LType> newSelection){
          setState(() {
            changeDisplay= newSelection.first;
          });
         }, 
         )
      ],) ,
      
body: changeDisplay== LType.recipies
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
enum LType{recipies,ingredients}