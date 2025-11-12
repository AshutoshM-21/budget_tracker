import 'package:budget_tracker/features/budgets/domain/entities/budget_entity.dart';
import 'package:equatable/equatable.dart';

class BudgetState extends Equatable {
  final List<BudgetEntity> budgets;
  final bool loading;
  final String? error;

  const BudgetState({
    required this.budgets,
    required this.loading,
    this.error,
  });

  factory BudgetState.initial() => const BudgetState(
        budgets: [],
        loading: false,
      );

  BudgetState copyWith({
    List<BudgetEntity>? budgets,
    bool? loading,
    String? error,
  }) {
    return BudgetState(
      budgets: budgets ?? this.budgets,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [budgets, loading, error];
}