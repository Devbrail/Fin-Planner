import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:paisa/src/domain/category/repository/category_repository.dart';

import 'src/app.dart';
import 'src/di/di.dart';
import 'src/domain/recurring/repository/recurring_repository.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configInjector(getIt);
  //await addDummyData();
  getIt.get<RecurringRepository>().checkForRecurring();
  getIt.get<CategoryRepository>().defaultCategories();
  runApp(const PaisaApp());
}
