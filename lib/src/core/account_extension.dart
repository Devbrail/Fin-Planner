import 'package:hive_flutter/adapters.dart';

import '../data/accounts/model/account.dart';
import 'common.dart';

extension AccountMapping on Account {
  double get initialAmount => amount ?? 0;
}

extension AccountsMapping on Box<Account> {
  double get totalAccountInitialAmount =>
      groupBy(values, (Account account) => account.key)
          .keys
          .map((accountId) => get(accountId)!)
          .map((account) => account.amount ?? 0)
          .fold<double>(0, (previousValue, element) => previousValue + element);
}
