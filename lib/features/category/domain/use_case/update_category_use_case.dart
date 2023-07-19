import 'package:injectable/injectable.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/category/domain/entities/update_category.dart';
import 'package:paisa/features/category/domain/repository/category_repository.dart';

@singleton
class UpdateCategoryUseCase extends UseCase<Future<void>, UpdateCategory> {
  UpdateCategoryUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;
  @override
  Future<void> call({UpdateCategory? params}) {
    return categoryRepository.updateCategory(
      key: params!.key,
      color: params.color!,
      icon: params.icon,
      name: params.name,
      budget: params.budget,
      desc: params.description,
      isBudget: params.isBudget,
    );
  }
}
