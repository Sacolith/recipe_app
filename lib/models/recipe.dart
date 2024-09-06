import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 0)
class Recipe{
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String prepTime;

  @HiveField(4)
  final String ingredients;

  @HiveField(5)
  final List <RecipeType> recipetype;
const Recipe({
  required this.id, required this.title, required this.description,
  required this.prepTime, required this.ingredients, required this.recipetype
});
}

@HiveType(typeId: 1)
enum RecipeType{

@HiveField(0)
breakfast,

@HiveField(1)
lunch,

@HiveField(2)
dinner,

@HiveField(3)
appetizer,

@HiveField(4)
salad,

@HiveField(5)
mainCourse,

@HiveField(6)
sideDish,

@HiveField(7)
bakedGoods,

@HiveField(8)
desert,

@HiveField(9)
snack,

@HiveField(10)
soups,

@HiveField(11)
holiday,

@HiveField(12)
vegetarian
}




