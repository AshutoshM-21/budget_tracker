

import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final int? id; // nullable because DB assigns it
  final String title;
  final double amount;
  final DateTime date;
  final int categoryId;
  final bool isExpense; // true = expense, false = income

  const TransactionEntity({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.isExpense,
  });

  @override
  List<Object?> get props => [id, title, amount, date, categoryId, isExpense];
}
