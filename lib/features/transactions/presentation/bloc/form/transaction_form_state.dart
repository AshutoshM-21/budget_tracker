import 'package:equatable/equatable.dart';

class TransactionFormState extends Equatable {
  final bool loading;

  final String title;
  final String amount;
  final int? categoryId;
  final DateTime date;
  final bool isExpense;

  final bool isEditing;
  final int? editingId;

  final String? error;
  final bool success;

  const TransactionFormState({
    required this.loading,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.date,
    required this.isExpense,
    required this.isEditing,
    required this.editingId,
    required this.error,
    required this.success,
  });

  factory TransactionFormState.initial() => TransactionFormState(
        loading: false,
        title: '',
        amount: '',
        categoryId: null,
        date: DateTime.now(),
        isExpense: true,
        isEditing: false,
        editingId: null,
        error: null,
        success: false,
      );

  TransactionFormState copyWith({
    bool? loading,
    String? title,
    String? amount,
    int? categoryId,
    DateTime? date,
    bool? isExpense,
    bool? isEditing,
    int? editingId,
    String? error,
    bool? success,
  }) {
    return TransactionFormState(
      loading: loading ?? this.loading,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      isExpense: isExpense ?? this.isExpense,
      isEditing: isEditing ?? this.isEditing,
      editingId: editingId ?? this.editingId,
      error: error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props =>
      [loading, title, amount, categoryId, date, isExpense, isEditing, editingId, error, success];
}
