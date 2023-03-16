import 'package:collection/collection.dart';

import '../../data/category/model/category_model.dart';
import '../../domain/category/entities/category.dart';

extension CategoryMapping on CategoryModel {
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

extension CategoriesMapping on Iterable<CategoryModel> {
  List<Category> toEntities() =>
      map((categoryModel) => categoryModel.toEntity())
          .sorted((a, b) => b.name.compareTo(a.name))
          .toList();
}
