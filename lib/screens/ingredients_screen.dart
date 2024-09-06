import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/provider/ingredient_provider.dart';
import 'package:recipe_app/widget/container.dart';

class IngredientsScreen extends StatefulWidget{
 const IngredientsScreen({super.key});

 @override
 State<IngredientsScreen> createState()=> IngredientState();
}
class IngredientState extends State<IngredientsScreen>{
late Box<Ingredient> ingredientBox;

@override
void initState(){
  super.initState();
  ingredientBox=Hive.box<Ingredient>('ingredients');
}

Future<void> _addIngredient() async{
  String name='';
  String description='';
IngredientType selected=IngredientType.meats;

await showDialog(context: context,
 builder: (context){
  return AlertDialog(
    title: const Text('Add Ingredient'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Name'),
          onChanged: (value)=> name=value,
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Description'),
          onChanged: (value)=> description=value,
        ),
        DropdownButton<IngredientType>(
              value: selected,
              items: IngredientType.values.map((IngredientType type) {
                return DropdownMenuItem<IngredientType>(
                  value: type,
                  child: Text(type.toString().split('.').last), 
                );
              }).toList(),
              onChanged: (IngredientType? newValue) {
                if (newValue != null) {
                  setState(() {
                    selected = newValue;
                  });
                  }
      }
      
          )
      ],
    ),
    actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newRecipe = Ingredient(
                  name: name,
                  description: description,
                  ingredienttype: [selected],
                   id: DateTime.now().toString(),
                );
                ingredientBox.add(newRecipe); 
                Navigator.of(context).pop();
                setState(() {}); 
              },
              child: const Text('Add'),
            ),
          ],
  );
 });
}

 @override
  Widget build(BuildContext context){
    final List<Ingredient> allIngredients=[
      ...Ipovider.ingred,
      
      // ignore: unnecessary_to_list_in_spreads
      ...ingredientBox.values.toList()
    ];
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
                builder: (context) => I_Card(ingredient: ingredients) )
      ),
       );
    },),
floatingActionButton:  FloatingActionButton(
  onPressed: _addIngredient,
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
          child: _cardInfo(ingredient),),
        ),
     );
  }
}

Widget _cardInfo(Ingredient ingredient) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
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