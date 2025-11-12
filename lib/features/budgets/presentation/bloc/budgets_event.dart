import 'package:budget_tracker/features/budgets/domain/entities/budget_entity.dart';
import 'package:equatable/equatable.dart';

abstract class BudgetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBudgets extends BudgetEvent {}

class AddBudgetEvent extends BudgetEvent {
  final BudgetEntity budget;
  AddBudgetEvent(this.budget);

  @override
  List<Object?> get props => [budget];
}

class UpdateBudgetEvent extends BudgetEvent {
  final BudgetEntity budget;
  UpdateBudgetEvent(this.budget);

  @override
  List<Object?> get props => [budget];
}

class DeleteBudgetEvent extends BudgetEvent {
  final int id;
  DeleteBudgetEvent(this.id);

  @override
  List<Object?> get props => [id];
}