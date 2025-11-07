
import 'package:budget_tracker/features/budgets/data/repositories/budget_repository_impl.dart';
import 'package:budget_tracker/features/budgets/domain/repositories/budget_repository.dart';
import 'package:budget_tracker/features/categories/data/repositories/category_repository_impl.dart';
import 'package:budget_tracker/features/categories/domain/repositories/category_repository.dart';
import 'package:budget_tracker/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:budget_tracker/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:budget_tracker/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:budget_tracker/services/db/drift/app_database.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ✅ Database
  final database = AppDatabase();
  sl.registerSingleton<AppDatabase>(database);

  // ✅ DAOs
  sl.registerSingleton(database.transactionsDao);
  sl.registerSingleton(database.categoriesDao);
  sl.registerSingleton(database.budgetsDao);

  // ✅ Repositories (bind abstraction → implementation)
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<BudgetRepository>(
    () => BudgetRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl()),
  );

}
