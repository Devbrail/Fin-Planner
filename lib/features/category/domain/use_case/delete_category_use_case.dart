import 'package:injectable/injectable.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/category/domain/repository/category_repository.dart';

@singleton
class DeleteCategoryUseCase implements UseCase<Future<void>, int> {
  DeleteCategoryUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  @override
  Future<void> call({int? params}) {
    return categoryRepository.deleteCategory(params!);
  }
}
