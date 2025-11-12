import 'package:budget_tracker/features/budgets/domain/repositories/budget_repository.dart';

class DeleteBudget {
  final BudgetRepository repo;

  DeleteBudget(this.repo);

  Future<void> call(int id) {
    return repo.deleteBudget(id);
  }
}