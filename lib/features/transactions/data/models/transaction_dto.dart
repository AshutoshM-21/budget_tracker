import 'package:budget_tracker/services/db/drift/app_database.dart';
import 'package:drift/drift.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionDto {
  final int? id;
  final String title;
  final double amount;
  final DateTime date;
  final int categoryId;
  final bool isExpense;

  TransactionDto({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.isExpense,
  });

  // Convert Entity → DTO
  factory TransactionDto.fromEntity(TransactionEntity entity) {
    return TransactionDto(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      date: entity.date,
      categoryId: entity.categoryId,
      isExpense: entity.isExpense,
    );
  }

  // Convert Drift Row → DTO → Entity
 factory TransactionDto.fromRow(TransactionsTableData row) {
  return TransactionDto(
    id: row.id,
    title: row.title,
    amount: row.amount,
    date: row.date,
    categoryId: row.categoryId,
    isExpense: row.isExpense,
  );
}


  // Convert DTO → Drift Companion
  TransactionsTableCompanion toCompanion() {
    return TransactionsTableCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      title: Value(title),
      amount: Value(amount),
      date: Value(date),
      categoryId: Value(categoryId),
      isExpense: Value(isExpense),
    );
  }

  // Convert DTO → Entity
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      title: title,
      amount: amount,
      date: date,
      categoryId: categoryId,
      isExpense: isExpense,
    );
  }
}
