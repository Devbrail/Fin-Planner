// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 0;

  @override
  Expense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expense(
      name: fields[0] as String,
      currency: fields[1] as double,
      time: fields[4] as DateTime,
      category: fields[5] as Category,
      account: fields[6] as Account,
      addOrSub: fields[3] as bool,
      type: fields[7] == null
          ? TransactonType.expense
          : fields[7] as TransactonType?,
    );
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(3)
      ..write(obj.addOrSub)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.account)
      ..writeByte(7)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
