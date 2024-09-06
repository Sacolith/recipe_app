// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientAdapter extends TypeAdapter<Ingredient> {
  @override
  final int typeId = 2;

  @override
  Ingredient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ingredient(
      ingredienttype: (fields[1] as List).cast<IngredientType>(),
      description: fields[2] as String,
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ingredient obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.ingredienttype)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IngredientTypeAdapter extends TypeAdapter<IngredientType> {
  @override
  final int typeId = 3;

  @override
  IngredientType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return IngredientType.fruits;
      case 1:
        return IngredientType.vegetables;
      case 2:
        return IngredientType.meats;
      case 3:
        return IngredientType.dairy;
      case 4:
        return IngredientType.spices;
      case 5:
        return IngredientType.herbs;
      case 6:
        return IngredientType.oils;
      case 7:
        return IngredientType.sweeteners;
      default:
        return IngredientType.fruits;
    }
  }

  @override
  void write(BinaryWriter writer, IngredientType obj) {
    switch (obj) {
      case IngredientType.fruits:
        writer.writeByte(0);
        break;
      case IngredientType.vegetables:
        writer.writeByte(1);
        break;
      case IngredientType.meats:
        writer.writeByte(2);
        break;
      case IngredientType.dairy:
        writer.writeByte(3);
        break;
      case IngredientType.spices:
        writer.writeByte(4);
        break;
      case IngredientType.herbs:
        writer.writeByte(5);
        break;
      case IngredientType.oils:
        writer.writeByte(6);
        break;
      case IngredientType.sweeteners:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
