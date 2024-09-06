import 'package:flutter/material.dart';
import 'package:recipe_app/provider/ingredient_provider.dart';
import 'package:recipe_app/widget/container.dart';

class IngredientsScreen extends StatefulWidget{
 const IngredientsScreen({super.key});

 @override
 State<IngredientsScreen> createState()=> IngredientState();
}
class IngredientState extends State<IngredientsScreen>{
late List ing;

 @override
  Widget build(BuildContext context){
    return Scaffold(
  body: GestureDetector(
    child: Hero(
      tag: 'recipe-card',
      child: _cardInfo(size: 70),
      ),
      onTap: ()=> Navigator.of(context).push<void>(
        MaterialPageRoute(builder: (context)=> const I_Card() )
      ),
       ),
floatingActionButton:  IconButton(onPressed: (){
          }, 
          icon: const Icon(Icons.add),
          tooltip: 'Add Ingredient'),
  );
  }
}

class I_Card extends StatelessWidget{
  const I_Card({super.key});
 @override
  Widget build(BuildContext context){
     return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'ingredient-tag',
          child: _cardInfo(
            size: 70.0
          ),),
        ),
     );
  }
}

StatelessWidget _cardInfo({
 required double size
}){
  var ing=Ipovider.ingred;
  return Card(
    child:  ListView.builder(
      itemCount: ing.length,
      itemBuilder: (context,i){
        return Padding(
          padding: const EdgeInsets.all(8),
        child: Column(children: [
          Card(child:IngCon(ingredients: ing[i])),  
        ],
        ) 
        ,);
        
      } )
    );

}