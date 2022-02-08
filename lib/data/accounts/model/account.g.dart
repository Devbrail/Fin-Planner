// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 2;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      name: fields[0] as String,
      icon: fields[1] as int,
      bankName: fields[3] as String,
      validThru: fields[4] as DateTime,
      number: fields[5] as String,
      cardType: fields[6] == null ? CardType.debitcard : fields[6] as CardType?,
      isPredefined: fields[2] as bool,
    )..superId = fields[7] == null ? 0 : fields[7] as int?;
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.isPredefined)
      ..writeByte(3)
      ..write(obj.bankName)
      ..writeByte(4)
      ..write(obj.validThru)
      ..writeByte(5)
      ..write(obj.number)
      ..writeByte(6)
      ..write(obj.cardType)
      ..writeByte(7)
      ..write(obj.superId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
