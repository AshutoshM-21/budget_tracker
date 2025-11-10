import 'package:equatable/equatable.dart';

abstract class TransactionFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Load for edit
class LoadTransactionForEdit extends TransactionFormEvent {
  final int id;
  LoadTransactionForEdit(this.id);

  @override
  List<Object?> get props => [id];
}

// Title
class UpdateTitle extends TransactionFormEvent {
  final String value;
  UpdateTitle(this.value);

  @override
  List<Object?> get props => [value];
}

// Amount (string)
class UpdateAmount extends TransactionFormEvent {
  final String value;
  UpdateAmount(this.value);

  @override
  List<Object?> get props => [value];
}

// Category
class UpdateCategory extends TransactionFormEvent {
  final int categoryId;
  UpdateCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

// Date
class UpdateDate extends TransactionFormEvent {
  final DateTime date;
  UpdateDate(this.date);

  @override
  List<Object?> get props => [date];
}

// Income / Expense toggle
class UpdateIsExpense extends TransactionFormEvent {
  final bool isExpense;
  UpdateIsExpense(this.isExpense);

  @override
  List<Object?> get props => [isExpense];
}

// Submit
class SubmitTransaction extends TransactionFormEvent {}
