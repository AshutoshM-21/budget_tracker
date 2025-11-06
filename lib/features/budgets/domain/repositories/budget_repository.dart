import 'package:budget_tracker/features/budgets/domain/entities/budget_entity.dart';

abstract class BudgetRepository {
  Future<void> setBudget(BudgetEntity budget);
  Future<List<BudgetEntity>> getBudgets();
}