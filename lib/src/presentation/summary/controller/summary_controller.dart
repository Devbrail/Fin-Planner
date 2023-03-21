import 'package:injectable/injectable.dart';

import '../../../domain/account/entities/account.dart';
import '../../../domain/account/use_case/account_use_case.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/category/use_case/category_use_case.dart';

@singleton
class SummaryController {
  final GetAccountUseCase getAccountUseCase;
  final GetCategoryUseCase getCategoryUseCase;

  SummaryController({
    required this.getAccountUseCase,
    required this.getCategoryUseCase,
  });

  Category? getCategory(int categoryId) => getCategoryUseCase(categoryId);
  Account? getAccount(int accountId) => getAccountUseCase(accountId);
}
