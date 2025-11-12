import 'package:budget_tracker/services/db/drift/app_database.dart';
import 'package:budget_tracker/services/db/drift/daos/budgets_dao.dart';
import 'package:budget_tracker/services/db/drift/daos/transactions_dao.dart';
import '../../domain/entities/budget_entity.dart';
import '../../domain/repositories/budget_repository.dart';
import '../models/budget_dto.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetsDao budgetsDao;
  final TransactionsDao transactionsDao;

  BudgetRepositoryImpl(this.budgetsDao, this.transactionsDao);

  @override
  Future<List<BudgetEntity>> getBudgets() async {
    final rows = await budgetsDao.getBudgets();

    List<BudgetEntity> result = [];

    for (final row in rows) {
      final spent = await transactionsDao.getSpentForCategoryMonth(
        row.categoryId,
        row.month,
      );

      result.add(
        BudgetDto.fromRow(row).toEntity().copyWithSpent(spent),
      );
    }

    return result;
  }

  @override
  Future<void> addBudget(BudgetEntity budget) async {
    final dto = BudgetDto.fromEntity(budget);
    await budgetsDao.insertBudget(dto.toCompanion());
  }

  @override
  Future<void> updateBudget(BudgetEntity budget) async {
    final dto = BudgetDto.fromEntity(budget);
    await budgetsDao.updateBudget(dto.toCompanion());
  }

  @override
  Future<void> deleteBudget(int id) {
    return budgetsDao.deleteBudget(id);
  }
}