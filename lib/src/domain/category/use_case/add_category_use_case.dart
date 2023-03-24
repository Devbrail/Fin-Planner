import 'package:injectable/injectable.dart';

import '../repository/category_repository.dart';

@singleton
class AddCategoryUseCase {
  final CategoryRepository categoryRepository;

  AddCategoryUseCase({required this.categoryRepository});

  Future<void> call({
    required String name,
    required String? desc,
    required int icon,
    required bool isBudget,
    required int color,
    double? budget = -1,
  }) async =>
      categoryRepository.addCategory(
        name: name,
        desc: desc,
        icon: icon,
        budget: budget,
        isBudget: isBudget,
        color: color,
      );
}
