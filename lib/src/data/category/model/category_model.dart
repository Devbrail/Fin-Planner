import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? description;

  @HiveField(2)
  int icon;

  @HiveField(4, defaultValue: 0)
  int? superId;

  @HiveField(6, defaultValue: 0)
  double? budget;

  @HiveField(7, defaultValue: false)
  bool isBudget;

  @HiveField(8, defaultValue: 0xFFFFC107)
  int? color;

  CategoryModel({
    required this.icon,
    required this.name,
    required this.color,
    this.description,
    this.isBudget = false,
    this.budget = -1,
    this.superId,
  });

  @override
  List<Object?> get props => [name, icon, description];

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        budget: json["budget"],
        color: json["color"],
      )..superId = json["superId"];

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'icon': icon,
        'superId': superId,
        'budget': budget,
        'color': color,
      };
}
