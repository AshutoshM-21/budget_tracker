import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_tracker/features/categories/domain/usecases/get_categories.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/add_transaction.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/update_transaction.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/get_transaction_by_id.dart';
import 'transaction_form_event.dart';
import 'transaction_form_state.dart';

class TransactionFormBloc extends Bloc<TransactionFormEvent, TransactionFormState> {
  final AddTransaction addTransaction;
  final UpdateTransaction updateTransaction;
  final GetTransactionById getTransactionById;
  final GetCategories getCategories;

  TransactionFormBloc({
    required this.addTransaction,
    required this.updateTransaction,
    required this.getTransactionById,
    required this.getCategories,
  }) : super(TransactionFormState.initial()) {
    on<LoadCategoriesForForm>(_loadCategories);
    on<LoadTransactionForEdit>(_loadForEdit);
    on<UpdateTitle>(_updateTitle);
    on<UpdateAmount>(_updateAmount);
    on<UpdateIsExpense>(_updateIsExpense);
    on<UpdateCategory>(_updateCategory);
    on<UpdateDate>(_updateDate);
    on<SubmitTransaction>(_submit);
  }

  // ✅ Load all categories for dropdown
  Future<void> _loadCategories(
      LoadCategoriesForForm event, Emitter<TransactionFormState> emit) async {
    final list = await getCategories();

    emit(state.copyWith(
      categories: list,
      categoryId: state.categoryId ?? (list.isNotEmpty ? list.first.id : null),
    ));
  }

  // ✅ Load data for editing an existing transaction
  Future<void> _loadForEdit(
    LoadTransactionForEdit event, Emitter<TransactionFormState> emit) async {
  emit(state.copyWith(loading: true));

  final txn = await getTransactionById(event.id);

  if (txn == null) {
    emit(state.copyWith(
      loading: false,
      error: "Transaction not found",
    ));
    return;
  }

  emit(state.copyWith(
    loading: false,
    title: txn.title,
    amount: txn.amount,
    date: txn.date,
    isExpense: txn.isExpense,
    categoryId: txn.categoryId,
  ));
}


  // ✅ Title update
  void _updateTitle(UpdateTitle event, Emitter<TransactionFormState> emit) {
    emit(state.copyWith(title: event.value));
  }

  // ✅ Amount update
  void _updateAmount(UpdateAmount event, Emitter<TransactionFormState> emit) {
    emit(state.copyWith(amount: event.value));
  }

  // ✅ Category update
  void _updateCategory(UpdateCategory event, Emitter<TransactionFormState> emit) {
    emit(state.copyWith(categoryId: event.categoryId));
  }

  // ✅ Expense/Income toggle
  void _updateIsExpense(
      UpdateIsExpense event, Emitter<TransactionFormState> emit) {
    emit(state.copyWith(isExpense: event.value));
  }

  // ✅ Date update
  void _updateDate(UpdateDate event, Emitter<TransactionFormState> emit) {
    emit(state.copyWith(date: event.date));
  }

  // ✅ Submit new or updated transaction
  Future<void> _submit(
      SubmitTransaction event, Emitter<TransactionFormState> emit) async {
    emit(state.copyWith(loading: true, error: null));

    try {
      if (state.isEditing) {
        await updateTransaction(state.toEntity());
      } else {
        await addTransaction(state.toEntity());
      }

      emit(state.copyWith(loading: false, success: true));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
