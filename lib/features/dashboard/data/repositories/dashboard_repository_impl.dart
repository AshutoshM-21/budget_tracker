
import 'package:budget_tracker/services/db/drift/app_database.dart';

import '../../domain/entities/dashboard_summary_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final AppDatabase db;

  DashboardRepositoryImpl(this.db);

  @override
  Future<DashboardSummaryEntity> getDashboardSummary() async {
    final transactions = await db.transactionsDao.getTransactions();

    double income = 0;
    double expense = 0;

    for (var tx in transactions) {
      if (tx.isExpense) {
        expense += tx.amount;
      } else {
        income += tx.amount;
      }
    }

    return DashboardSummaryEntity(
      totalBalance: income - expense,
      totalIncome: income,
      totalExpense: expense,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getSpendByCategory() {
    return db.transactionsDao.getSpendByCategory();
  }

  @override
  Future<List<dynamic>> getRecentTransactions() {
    return db.transactionsDao.getRecentTransactions();
  }
}
