import 'package:equatable/equatable.dart';

class AddCategory extends Equatable {
  final double? budget;
  final int? color;
  final String? description;
  final int? icon;
  final bool isBudget;
  final bool isDefault;
  final String? name;

  const AddCategory({
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
        budget,
        color,
        description,
        icon,
        isBudget,
        isDefault,
        name,
      ];
}
