import 'package:budget_tracker/services/db/drift/app_database.dart';
import '../../domain/entities/budget_entity.dart';
import '../../domain/repositories/budget_repository.dart';
import '../models/budget_dto.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final AppDatabase db;

  BudgetRepositoryImpl(this.db);

  @override
  Future<void> setBudget(BudgetEntity budget) async {
    await db.budgetsDao.insertBudget(
      BudgetDto.fromEntity(budget).toCompanion(),
    );
  }

  @override
Future<List<BudgetEntity>> getBudgets() async {
  final rows = await db.budgetsDao.getBudgets();
  return rows.map((row) => BudgetDto.fromRow(row).toEntity()).toList();
}

}
