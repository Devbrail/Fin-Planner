import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 11)
enum TransactionType {
  @HiveField(1)
  expense('expense'),
  @HiveField(0)
  income('income'),
  @HiveField(2)
  transfer('transfer'),
  @HiveField(3)
  recurring('recurring');

  final String type;
  const TransactionType(this.type);
}
