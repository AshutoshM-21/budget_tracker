import 'package:budget_tracker/features/budgets/data/repositories/budget_repository_impl.dart';
import 'package:budget_tracker/features/budgets/domain/repositories/budget_repository.dart';
import 'package:budget_tracker/features/categories/data/repositories/category_repository_impl.dart';
import 'package:budget_tracker/features/categories/domain/repositories/category_repository.dart';
import 'package:budget_tracker/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:budget_tracker/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:budget_tracker/features/dashboard/domain/usecases/get_dashboard_summary.dart';
import 'package:budget_tracker/features/dashboard/domain/usecases/get_recent_transactions.dart';
import 'package:budget_tracker/features/dashboard/domain/usecases/get_spend_by_category.dart';
import 'package:budget_tracker/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:budget_tracker/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:budget_tracker/services/db/drift/app_database.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ✅ Database
  final database = AppDatabase();
  sl.registerSingleton<AppDatabase>(database);

  //  DAOs
  sl.registerSingleton(database.transactionsDao);
  sl.registerSingleton(database.categoriesDao);
  sl.registerSingleton(database.budgetsDao);
  
  // UseCases
  sl.registerLazySingleton(() => GetDashboardSummary(sl()));
  sl.registerLazySingleton(() => GetRecentTransactions(sl()));
  sl.registerLazySingleton(() => GetSpendByCategory(sl()));

// DashboardBloc
sl.registerFactory(
  () => DashboardBloc(
    getSummary: sl(),
    getRecent: sl(),
    getSpend: sl(),
  ),
);
  // Repositories (bind abstraction → implementation)
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<BudgetRepository>(() => BudgetRepositoryImpl(sl()));

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl()),
  );
}
