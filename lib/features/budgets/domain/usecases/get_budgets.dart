import 'package:budget_tracker/features/budgets/domain/entities/budget_entity.dart';
import 'package:budget_tracker/features/budgets/domain/repositories/budget_repository.dart';

class GetBudgets {
  final BudgetRepository repo;

  GetBudgets(this.repo);

  Future<List<BudgetEntity>> call() => repo.getBudgets();
}