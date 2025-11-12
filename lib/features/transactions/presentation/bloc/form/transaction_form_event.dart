import 'package:equatable/equatable.dart';

abstract class TransactionFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Load categories
class LoadCategoriesForForm extends TransactionFormEvent {}

// Load transaction for editing
class LoadTransactionForEdit extends TransactionFormEvent {
  final int id;
  LoadTransactionForEdit(this.id);
}

// Title
class UpdateTitle extends TransactionFormEvent {
  final String value;
  UpdateTitle(this.value);
}

// Amount
class UpdateAmount extends TransactionFormEvent {
  final double value;
  UpdateAmount(this.value);
}

// Category
class UpdateCategory extends TransactionFormEvent {
  final int categoryId;
  UpdateCategory(this.categoryId);
}

// Expense toggle
class UpdateIsExpense extends TransactionFormEvent {
  final bool value;
  UpdateIsExpense(this.value);
}

// Date
class UpdateDate extends TransactionFormEvent {
  final DateTime date;
  UpdateDate(this.date);
}

// Submit
class SubmitTransaction extends TransactionFormEvent {}
