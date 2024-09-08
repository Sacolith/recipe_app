
import 'package:hive_flutter/adapters.dart';

///generate this file make sure you have hive_generator in dev dependences  and flutter build runner
///generate by going to terminal and entering "flutter packages pub run build_runner build"
part 'ingredient.g.dart';

//setting up the hive database (Remember)each typeId is unique
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
