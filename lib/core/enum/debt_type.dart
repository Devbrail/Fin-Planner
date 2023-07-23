import 'package:hive/hive.dart';

part 'debt_type.g.dart';

@HiveType(typeId: 15)
enum DebitType {
  @HiveField(1)
  debit,
  @HiveField(2)
  credit;
}
