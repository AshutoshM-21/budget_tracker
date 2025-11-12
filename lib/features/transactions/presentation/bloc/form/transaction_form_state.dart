import 'package:equatable/equatable.dart';
import 'package:budget_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction_entity.dart';

class TransactionFormState extends Equatable {
  final String title;
  final double amount;
  final DateTime date;
  final bool isExpense;

  final int? id;
  final int? categoryId;

  final List<CategoryEntity> categories;

  final bool loading;
  final bool success;
  final String? error;

  const TransactionFormState({
    required this.title,
    required this.amount,
    required this.date,
    required this.isExpense,
    required this.id,
    required this.categoryId,
    required this.categories,
    required this.loading,
    required this.success,
    required this.error,
  });

  factory TransactionFormState.initial() {
    return TransactionFormState(
      title: "",
      amount: 0.0,
      date: DateTime.now(),
      isExpense: true,
      id: null,
      categoryId: null,
      categories: const [],
      loading: false,
      success: false,
      error: null,
    );
  }

  TransactionFormState copyWith({
    String? title,
    double? amount,
    DateTime? date,
    bool? isExpense,
    int? id,
    int? categoryId,
    List<CategoryEntity>? categories,
    bool? loading,
    bool? success,
    String? error,
  }) {
    return TransactionFormState(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      isExpense: isExpense ?? this.isExpense,
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      categories: categories ?? this.categories,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      error: error,
    );
  }

  bool get isEditing => id != null;

  // ✅ Needed by bloc.submit()
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      title: title,
      amount: amount,
      date: date,
      isExpense: isExpense,
      categoryId: categoryId!,
    );
  }

  @override
  List<Object?> get props => [
        title,
        amount,
        date,
        isExpense,
        id,
        categoryId,
        categories,
        loading,
        success,
        error,
      ];
}
