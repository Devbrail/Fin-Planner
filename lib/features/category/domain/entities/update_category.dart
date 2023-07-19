import 'package:equatable/equatable.dart';

class UpdateCategory extends Equatable {
  final double? budget;
  final int? color;
  final String? description;
  final int? icon;
  final bool isBudget;
  final bool isDefault;
  final String? name;
  final int key;

  const UpdateCategory(
    this.key, {
    this.budget,
    this.color,
    this.description,
    this.icon,
    this.isBudget = false,
    this.isDefault = false,
    this.name,
  });

  @override
  List<Object?> get props => [
        key,
        budget,
        color,
        description,
        icon,
        isBudget,
        isDefault,
        name,
      ];
}
