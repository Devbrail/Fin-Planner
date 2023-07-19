import 'package:injectable/injectable.dart';

import '../repository/category_repository.dart';

@singleton
class AddCategoryUseCase {
  AddCategoryUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  Future<void> call({
    required String name,
    required String? desc,
    required int icon,
    required bool isBudget,
    required int color,
    double? budget = -1,
    bool isDefault = false,
  }) async =>
      categoryRepository.addCategory(
        name: name,
        desc: desc,
        icon: icon,
        budget: budget,
        isBudget: isBudget,
        color: color,
        isDefault: isDefault,
      );
}
