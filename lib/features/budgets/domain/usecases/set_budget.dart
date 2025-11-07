import 'package:budget_tracker/features/budgets/domain/entities/budget_entity.dart';
import 'package:budget_tracker/features/budgets/domain/repositories/budget_repository.dart';

class SetBudget {
  final BudgetRepository repo;

  SetBudget(this.repo);

  Future<void> call(BudgetEntity budget) => repo.setBudget(budget);
}