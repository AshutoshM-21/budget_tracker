import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/budgets_table.dart';
import '../tables/transactions_table.dart';
import '../tables/categories_table.dart';

part 'budgets_dao.g.dart';

@DriftAccessor(tables: [BudgetsTable, TransactionsTable, CategoriesTable])
class BudgetsDao extends DatabaseAccessor<AppDatabase>
    with _$BudgetsDaoMixin {
  BudgetsDao(AppDatabase db) : super(db);

  Future<int> insertBudget(BudgetsTableCompanion data) =>
      into(budgetsTable).insert(data);

  Future<bool> updateBudget(BudgetsTableCompanion data) =>
      update(budgetsTable).replace(data);

  Future<List<BudgetsTableData>> getBudgets() =>
      select(budgetsTable).get();

  Future<double> getSpentAmountForCategory(int categoryId) async {
    final result = await customSelect(
      '''
      SELECT SUM(amount) AS total
      FROM transactions_table
      WHERE category_id = ? AND is_expense = 1
      ''',
      variables: [Variable(categoryId)],
      readsFrom: {transactionsTable},
    ).getSingle();

    return (result.data["total"] ?? 0) as double;
  }
}
