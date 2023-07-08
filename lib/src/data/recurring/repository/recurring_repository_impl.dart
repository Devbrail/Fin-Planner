import 'package:injectable/injectable.dart';

import '../../../core/common.dart';
import '../../../core/enum/recurring_type.dart';
import '../../../core/enum/transaction_type.dart';
import '../../../core/extensions/recurring_extension.dart';
import '../../../domain/recurring/repository/recurring_repository.dart';
import '../../expense/data_sources/local_expense_data_manager.dart';
import '../../expense/model/expense_model.dart';
import '../data_sources/local_recurring_data_manager.dart';
import '../model/recurring.dart';

@Singleton(as: RecurringRepository)
class RecurringRepositoryImpl implements RecurringRepository {
  RecurringRepositoryImpl(this.dataManager, this.expenseDataManager);

  final LocalRecurringDataManager dataManager;
  final ExpenseLocalDataManager expenseDataManager;

  @override
  Future<void> addRecurringEvent(
    String name,
    double amount,
    DateTime recurringTime,
    RecurringType recurringType,
    int selectedAccountId,
    int selectedCategoryId,
    TransactionType transactionType,
  ) {
    return dataManager.addRecurringEvent(
      RecurringModel(
        name: name,
        amount: amount,
        recurringType: recurringType,
        recurringDate: recurringTime,
        accountId: selectedAccountId,
        categoryId: selectedCategoryId,
        transactionType: transactionType,
      ),
    );
  }

  @override
  Future<void> checkForRecurring() async {
    final List<RecurringModel> recurringModels = dataManager.recurringModels();
    final now = DateTime.now();
    for (final RecurringModel recurringModel in recurringModels) {
      if (recurringModel.recurringDate.isBefore(now)) {
        final nextTime = recurringModel.recurringType.getTime;

        final numberOfTimes = recurringModel.recurringType
            .differenceInNumber(now, recurringModel.recurringDate);
        for (var i = 0; i < numberOfTimes; i++) {
          final ExpenseModel addExpenseModel = recurringModel
              .toExpenseModel(recurringModel.recurringDate.add(nextTime * i));
          await expenseDataManager.add(addExpenseModel);
        }
        final RecurringModel saveExpense = recurringModel.copyWith(
          recurringDate:
              recurringModel.recurringDate.add(nextTime * (numberOfTimes + 1)),
        );

        await dataManager.addRecurringEvent(saveExpense);
        await dataManager.clearRecurring(recurringModel.superId!);
      }
    }
  }

  /*  @override
  Future<void> checkForRecurring() async {
    final List<RecurringModel> recurringModels = dataManager.recurringModels();
    final now = DateTime.now();
    for (final RecurringModel recurringModel in recurringModels) {
      if (recurringModel.recurringDate.isBefore(now)) {
        final nextTime = recurringModel.recurringType.getTime;

        final numberOfTimes = recurringModel.recurringType
            .differenceInNumber(now, recurringModel.recurringDate);
        /*  for (var i = 0; i < numberOfTimes; i++) {
          final ExpenseModel currentExpense = expenseModel.copyWith(
            type: TransactionType.expense,
            time: expenseModel.recurringDate!.add(nextTime * i),
          );
          await dataSource.addOrUpdateExpense(currentExpense);
        }
        final ExpenseModel saveExpense = expenseModel.copyWith(
          recurringDate:
              expenseModel.recurringDate?.add(nextTime * numberOfTimes),
        );

        await dataSource.addOrUpdateExpense(saveExpense);
        await dataSource.clearExpense(expenseModel.superId!); */
      }
    }
  } */
}
