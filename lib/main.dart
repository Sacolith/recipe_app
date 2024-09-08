import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/design/colors.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/home_screen_setup.dart';
import 'package:recipe_app/services/state_service.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();

//Waiting for hive database to initialize
await Hive.initFlutter();

//the adapters are in the generated files more info in Models
Hive.registerAdapter(RecipeAdapter());
Hive.registerAdapter(RecipeTypeAdapter());
Hive.registerAdapter(IngredientTypeAdapter());
Hive.registerAdapter(IngredientAdapter());

//opening Boxes need be done or else errors (DAYS AND DAYS OF ERRORS)
await Hive.openBox<Recipe>('recipes');
await Hive.openBox<Ingredient>('ingredients');

final recipeBox= await Hive.openBox<Recipe>('recipies');
final ingredientBox= await Hive.openBox<Ingredient>('ingredients');

  runApp(
    MultiProvider(
      providers: [
        //Initialize providers to avoid errors(OR ELSE)
        ChangeNotifierProvider(create: (_) => StaServ(recipeBox)),  // Provide StaServ here
       ChangeNotifierProvider(create: (_) => IngredServ(ingredientBox)) 
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: const HomepageSetup(),
      theme: _themeData(),
    );
  }
}

//Basic theme
ThemeData _themeData(){
  return ThemeData(
    appBarTheme: const AppBarTheme(
      
      backgroundColor: Color.fromARGB(177, 215, 213, 107)
    ) ,
   scaffoldBackgroundColor: Cols.rasberry
  );
}