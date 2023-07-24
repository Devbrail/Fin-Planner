import 'package:paisa/core/common_enum.dart';
import 'package:paisa/features/account/data/model/account_model.dart';
import 'package:paisa/features/category/data/model/category_model.dart';

class CombinedTransaction {
  final AccountModel? accountModel;
  final CategoryModel? categoryModel;
  final double? currency;
  final String? description;
  final String? name;
  final int? superId;
  final DateTime? time;
  final TransactionType? type;

  CombinedTransaction({
    this.accountModel,
    this.categoryModel,
    this.currency,
    this.description,
    this.name,
    this.superId,
    this.time,
    this.type,
  });
}
