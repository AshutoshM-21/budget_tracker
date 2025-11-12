import 'package:budget_tracker/features/budgets/domain/entities/budget_entity.dart';
import 'package:budget_tracker/features/budgets/domain/repositories/budget_repository.dart';

class AddBudget {
  final BudgetRepository repo;

  AddBudget(this.repo);

  Future<void> call(BudgetEntity budget) {
    return repo.addBudget(budget);
  }
}