import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/home_screen_setup.dart';
import 'package:recipe_app/services/state_service.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();

await Hive.initFlutter();

Hive.registerAdapter(RecipeAdapter());
Hive.registerAdapter(RecipeTypeAdapter());
Hive.registerAdapter(IngredientAdapter());


await Hive.openBox<Recipe>('recipes');
await Hive.openBox<Ingredient>('ingredients');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StaServ()),  // Provide StaServ here
       ChangeNotifierProvider(create: (_) => IngredServ()) 
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomepageSetup()
    );
  }
}
