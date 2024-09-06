// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 0;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      prepTime: fields[3] as String,
      ingredients: fields[4] as String,
      recipetype: (fields[5] as List).cast<RecipeType>(),
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.prepTime)
      ..writeByte(4)
      ..write(obj.ingredients)
      ..writeByte(5)
      ..write(obj.recipetype);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecipeTypeAdapter extends TypeAdapter<RecipeType> {
  @override
  final int typeId = 1;

  @override
  RecipeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RecipeType.breakfast;
      case 1:
        return RecipeType.lunch;
      case 2:
        return RecipeType.dinner;
      case 3:
        return RecipeType.appetizer;
      case 4:
        return RecipeType.salad;
      case 5:
        return RecipeType.mainCourse;
      case 6:
        return RecipeType.sideDish;
      case 7:
        return RecipeType.bakedGoods;
      case 8:
        return RecipeType.desert;
      case 9:
        return RecipeType.snack;
      case 10:
        return RecipeType.soups;
      case 11:
        return RecipeType.holiday;
      case 12:
        return RecipeType.vegetarian;
      default:
        return RecipeType.breakfast;
    }
  }

  @override
  void write(BinaryWriter writer, RecipeType obj) {
    switch (obj) {
      case RecipeType.breakfast:
        writer.writeByte(0);
        break;
      case RecipeType.lunch:
        writer.writeByte(1);
        break;
      case RecipeType.dinner:
        writer.writeByte(2);
        break;
      case RecipeType.appetizer:
        writer.writeByte(3);
        break;
      case RecipeType.salad:
        writer.writeByte(4);
        break;
      case RecipeType.mainCourse:
        writer.writeByte(5);
        break;
      case RecipeType.sideDish:
        writer.writeByte(6);
        break;
      case RecipeType.bakedGoods:
        writer.writeByte(7);
        break;
      case RecipeType.desert:
        writer.writeByte(8);
        break;
      case RecipeType.snack:
        writer.writeByte(9);
        break;
      case RecipeType.soups:
        writer.writeByte(10);
        break;
      case RecipeType.holiday:
        writer.writeByte(11);
        break;
      case RecipeType.vegetarian:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
