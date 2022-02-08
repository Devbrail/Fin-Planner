// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactonTypeAdapter extends TypeAdapter<TransactonType> {
  @override
  final int typeId = 11;

  @override
  TransactonType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return TransactonType.expense;
      case 0:
        return TransactonType.income;
      case 2:
        return TransactonType.deposit;
      default:
        return TransactonType.expense;
    }
  }

  @override
  void write(BinaryWriter writer, TransactonType obj) {
    switch (obj) {
      case TransactonType.expense:
        writer.writeByte(1);
        break;
      case TransactonType.income:
        writer.writeByte(0);
        break;
      case TransactonType.deposit:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactonTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
