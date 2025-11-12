import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/transactions_table.dart';
import '../tables/categories_table.dart';

part 'transactions_dao.g.dart';

@DriftAccessor(tables: [TransactionsTable, CategoriesTable])
class TransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionsDaoMixin {
  TransactionsDao(AppDatabase db) : super(db);

  // Insert
  Future<int> insertTransaction(TransactionsTableCompanion data) =>
      into(transactionsTable).insert(data);

  // Update
  Future<bool> updateTransaction(TransactionsTableCompanion data) =>
      update(transactionsTable).replace(data);

  // Delete
  Future<int> deleteTransaction(int id) =>
      (delete(transactionsTable)..where((t) => t.id.equals(id))).go();

  // Fetch all
  Future<List<TransactionsTableData>> getTransactions() =>
      select(transactionsTable).get();

  // Fetch by ID
  Future<TransactionsTableData?> getTransactionById(int id) =>
      (select(transactionsTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  // Fetch recent transactions
  Future<List<TransactionsTableData>> getRecentTransactions([int limit = 5]) {
    return (select(transactionsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.date)])
          ..limit(limit))
        .get();
  }

  // Spend by category (sum of expenses)
  Future<List<Map<String, dynamic>>> getSpendByCategory() async {
    final result = await customSelect(
      '''
      SELECT c.name, SUM(t.amount) AS total
      FROM transactions_table t
      JOIN categories_table c ON c.id = t.category_id
      WHERE t.is_expense = 1
      GROUP BY t.category_id
      ''',
      readsFrom: {transactionsTable, categoriesTable},
    ).get(); 

    return result
        .map((row) => {"category": row.data["name"], "total": row.data["total"]})
        .toList();
  }

 Future<double> getSpentForCategoryMonth(int categoryId, int yyyymm) async {
  final year = yyyymm ~/ 100;
  final month = yyyymm % 100;

  // Start inclusive, end exclusive (next month)
  final start = DateTime(year, month, 1);
  final end = (month == 12) ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);

  final rows = await (select(transactionsTable)
        ..where((t) => t.categoryId.equals(categoryId))
        ..where((t) => t.isExpense.equals(true))
        ..where((t) => t.date.isBetweenValues(start, end)))
      .get();

  var total = 0.0;
  for (final r in rows) {
    total += r.amount; // r.amount is double from RealColumn
  }
  return total;
}


}
