// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 1;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      description: fields[1] as String,
      name: fields[0] as String,
      color: fields[8] == null ? 4294951175 : fields[8] as int?,
      isBudget: fields[7] == null ? false : fields[7] as bool,
      icon: fields[2] as int,
      budget: fields[6] == null ? 0 : fields[6] as double?,
    )..superId = fields[4] == null ? 0 : fields[4] as int?;
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.superId)
      ..writeByte(6)
      ..write(obj.budget)
      ..writeByte(7)
      ..write(obj.isBudget)
      ..writeByte(8)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
