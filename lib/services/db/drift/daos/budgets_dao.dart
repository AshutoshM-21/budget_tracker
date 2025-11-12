import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/budgets_table.dart';

part 'budgets_dao.g.dart';

@DriftAccessor(tables: [Budgets])
class BudgetsDao extends DatabaseAccessor<AppDatabase> with _$BudgetsDaoMixin {
  BudgetsDao(AppDatabase db) : super(db);

  Future<List<Budget>> getBudgets() => select(budgets).get();

  Future<int> insertBudget(BudgetsCompanion data) =>
      into(budgets).insert(data);

  Future<bool> updateBudget(BudgetsCompanion data) =>
      update(budgets).replace(data);

  Future<int> deleteBudget(int id) =>
      (delete(budgets)..where((tbl) => tbl.id.equals(id))).go();
}
