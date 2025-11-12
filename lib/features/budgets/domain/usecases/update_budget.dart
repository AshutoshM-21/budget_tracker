import 'package:budget_tracker/features/budgets/domain/entities/budget_entity.dart';
import 'package:budget_tracker/features/budgets/domain/repositories/budget_repository.dart';

class UpdateBudget {
  final BudgetRepository repo;

  UpdateBudget(this.repo);

  Future<void> call(BudgetEntity budget) {
    return repo.updateBudget(budget);
  }
}