import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../data/category/model/category_model.dart';
import '../../domain/category/entities/category.dart';

extension CategoryModelHelper on CategoryModel {
  Category toEntity() => Category(
        icon: icon,
        name: name,
        color: color,
        budget: budget,
        description: description,
        isBudget: isBudget,
        superId: superId,
      );
}

extension CategoryMapHelper on Map<dynamic, CategoryModel> {
  Map<int, Category> toMap() =>
      map((key, value) => MapEntry(key, value.toEntity()));
}

extension CategoryModelsHelper on Iterable<CategoryModel> {
  List<Map<String, dynamic>> toJson() {
    return map((e) => e.toJson()).toList();
  }

  List<Category> toEntities() =>
      map((categoryModel) => categoryModel.toEntity())
          .sorted((a, b) => a.name.compareTo(b.name))
          .toList();

  List<Category> toBudgetEntities() =>
      map((categoryModel) => categoryModel.toEntity())
          .where((element) => element.isBudget)
          .sorted((a, b) => a.name.compareTo(b.name))
          .toList();
}

extension CategoryHelper on Category {
  Color get foregroundColor => Color(color ?? Colors.amber.shade100.value);
  Color get backgroundColor =>
      Color(color ?? Colors.amber.shade100.value).withOpacity(0.25);

  double get finalBudget => budget ?? 0.0;
}
