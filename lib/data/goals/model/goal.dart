import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'goal.g.dart';

@HiveType(typeId: 4)
class Goal extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String title;

  @HiveField(1)
  double amount;

  @HiveField(4)
  String description;

  @HiveField(3)
  DateTime endTime;

  @HiveField(7)
  int? superId;

  Goal({
    required this.title,
    required this.amount,
    required this.description,
    required this.endTime,
  });

  @override
  List<Object?> get props => [title];
}
