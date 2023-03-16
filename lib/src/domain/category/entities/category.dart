import 'package:paisa/src/data/category/model/category_model.dart';

class Category extends CategoryModel {
  Category({
    required super.icon,
    required super.name,
    required super.color,
    super.description,
    super.isBudget = false,
    super.budget = -1,
    super.superId,
  });
}
