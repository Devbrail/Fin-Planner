// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseModelAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 0;

  @override
  ExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseModel(
      name: fields[0] as String,
      currency: fields[1] as double,
      time: fields[3] as DateTime,
      categoryId: fields[6] as int,
      accountId: fields[5] as int,
      type: fields[4] == null
          ? TransactionType.expense
          : fields[4] as TransactionType?,
      description: fields[8] as String?,
      superId: fields[7] as int?,
      fromAccountId: fields[9] as int?,
      toAccountId: fields[10] as int?,
      transferAmount: fields[11] == null ? 0.0 : fields[11] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.accountId)
      ..writeByte(6)
      ..write(obj.categoryId)
      ..writeByte(7)
      ..write(obj.superId)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.fromAccountId)
      ..writeByte(10)
      ..write(obj.toAccountId)
      ..writeByte(11)
      ..write(obj.transferAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
