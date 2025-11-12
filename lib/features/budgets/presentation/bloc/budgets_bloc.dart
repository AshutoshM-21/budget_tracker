import 'package:budget_tracker/features/budgets/domain/usecases/add_budget.dart';
import 'package:budget_tracker/features/budgets/domain/usecases/delete_budget.dart';
import 'package:budget_tracker/features/budgets/domain/usecases/get_budgets.dart';
import 'package:budget_tracker/features/budgets/domain/usecases/update_budget.dart';
import 'package:budget_tracker/features/budgets/presentation/bloc/budgets_event.dart';
import 'package:budget_tracker/features/budgets/presentation/bloc/budgets_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final GetBudgets getBudgets;
  final AddBudget addBudget;
  final UpdateBudget updateBudget;
  final DeleteBudget deleteBudget;

  BudgetBloc({
    required this.getBudgets,
    required this.addBudget,
    required this.updateBudget,
    required this.deleteBudget,
  }) : super(BudgetState.initial()) {
    on<LoadBudgets>(_load);
    on<AddBudgetEvent>(_add);
    on<UpdateBudgetEvent>(_update);
    on<DeleteBudgetEvent>(_delete);
  }

  Future<void> _load(LoadBudgets event, Emitter<BudgetState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final items = await getBudgets();
      emit(state.copyWith(loading: false, budgets: items));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _add(AddBudgetEvent event, Emitter<BudgetState> emit) async {
    await addBudget(event.budget);
    add(LoadBudgets());
  }

  Future<void> _update(UpdateBudgetEvent event, Emitter<BudgetState> emit) async {
    await updateBudget(event.budget);
    add(LoadBudgets());
  }

  Future<void> _delete(DeleteBudgetEvent event, Emitter<BudgetState> emit) async {
    await deleteBudget(event.id);
    add(LoadBudgets());
  }
}