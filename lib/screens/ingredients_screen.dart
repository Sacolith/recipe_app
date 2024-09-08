import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/design/colors.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/services/ingredient_service.dart';
import 'package:recipe_app/services/state_service.dart';

class IngredientsScreen extends StatefulWidget{
 const IngredientsScreen({super.key});

 @override
 State<IngredientsScreen> createState()=> IngredientState();
}
class IngredientState extends State<IngredientsScreen>{
 final Box<Ingredient> boxinstance= Hive.box<Ingredient>('ingredients');

 @override
  Widget build(BuildContext context){
    final IngredServ ingredServ=IngredServ(boxinstance); 
    final List<Ingredient> allIngredients= ingredServ.allIngreds;
 final IngredientService ingredientService = IngredientService(
      context: context,
      ingredientBox: boxinstance,
    );

    return Scaffold(
  body: ListView.builder(
    itemCount: allIngredients.length,
    itemBuilder: (context,index){
      final ingredients= allIngredients[index];
       return GestureDetector(
    child: Hero(
      tag: 'Ingredient-card-${ingredients.id}',
      child: _cardInfo(ingredients),
      ),
     onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => I_Card(ingredient: ingredients) 
                )
      ),
       );
    },),
floatingActionButton:  FloatingActionButton(
  onPressed: ()async {
           await ingredientService.addIngredient();
           setState(() {});
  },
  tooltip: 'Add Ingredient',
  child: const Icon(Icons.add),
),
  );
  }
}

// ignore: camel_case_types
class I_Card extends StatelessWidget{
  final Ingredient ingredient;
  const I_Card({super.key, required this.ingredient});
 @override
  Widget build(BuildContext context){
     return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'Ingredient-card-${ingredient.id}',
          flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
            return ScaleTransition(
              scale:animation.drive(Tween<double>(begin: 1.0, end: 1.1).chain(CurveTween(curve: Curves.easeInOut))),
              child: _cardInfo(ingredient),

               );
          } ,
          child: _buildCardWithSize(context,ingredient),
          ),
        ),
     );
  }
}

Widget _buildCardWithSize(BuildContext context, Ingredient ingredient) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width * 0.5, 
      child: _cardInfo(ingredient),
    );
  }

Widget _cardInfo(Ingredient ingredient) {
  return Card(
    color: Cols.cyber_yellow,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ingredient.name, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 8),
          Text('Description: ${ingredient.description}',style: const TextStyle(fontSize: 20),),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}