
import 'package:hive_flutter/adapters.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 2)
class Ingredient extends HiveObject{

  @HiveField(0)
  final String name;

@HiveField(1)
  List<IngredientType> ingredienttype;

  @HiveField(2)
   final String description;

   @HiveField(3)
   final String id;
    Ingredient({ required this.id,required this.ingredienttype,
    required this.description, required this.name
   });
}

@HiveType(typeId: 3)
enum IngredientType{
  
  @HiveField(0)
  fruits,

@HiveField(1)
  vegetables,
  
  @HiveField(2)
  meats,
  
  @HiveField(3)
  dairy,
  
  @HiveField(4)
  spices,
  
  @HiveField(5)
  herbs,
  
  @HiveField(6)
  oils,
  
  @HiveField(7)
  sweeteners
}
