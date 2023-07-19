import 'package:injectable/injectable.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/category/domain/entities/add_category.dart';
import 'package:paisa/features/category/domain/repository/category_repository.dart';

@singleton
class AddCategoryUseCase extends UseCase<Future<void>, AddCategory> {
  AddCategoryUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;
  @override
  Future<void> call({AddCategory? params}) {
    return categoryRepository.addCategory(
      name: params!.name,
      desc: params.description,
      icon: params.icon,
      budget: params.budget,
      isBudget: params.isBudget,
      color: params.color,
      isDefault: params.isDefault,
    );
  }
}
