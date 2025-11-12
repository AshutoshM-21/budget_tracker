import 'package:budget_tracker/services/db/drift/app_database.dart';
import 'package:budget_tracker/features/budgets/data/models/budget_dto.dart';

import '../../domain/entities/dashboard_summary_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final AppDatabase db;

  DashboardRepositoryImpl(this.db);

  @override
  Future<DashboardSummaryEntity> getDashboardSummary() async {
    // ✅ Fetch all transactions
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

    // ✅ Fetch all budgets (Drift rows)
    final budgets = await db.budgetsDao.getBudgets();

    // ✅ Convert each to DTO to safely access spentAmount
    final dtoList = budgets.map((b) => BudgetDto.fromRow(b)).toList();

    // ✅ Calculate totals
    final totalLimit = dtoList.fold<double>(0.0, (sum, b) => sum + (b.limitAmount ?? 0.0));
    final totalSpent = dtoList.fold<double>(0.0, (sum, b) => sum + (b.spentAmount ?? 0.0));

    // ✅ Calculate overall usage percentage (0–100)
    final overallUsage = totalLimit == 0
        ? 0.0
        : ((totalSpent / totalLimit) * 100).clamp(0.0, 100.0);

    // ✅ Return summary entity
    return DashboardSummaryEntity(
      totalBalance: income - expense,
      totalIncome: income,
      totalExpense: expense,
      totalLimit: totalLimit,
      totalSpent: totalSpent,
      overallUsage: overallUsage,
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
