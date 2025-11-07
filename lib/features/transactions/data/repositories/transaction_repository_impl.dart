import 'package:budget_tracker/services/db/drift/app_database.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../models/transaction_dto.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final AppDatabase db;

  TransactionRepositoryImpl(this.db);

  @override
  Future<void> addTransaction(TransactionEntity tx) async {
    await db.transactionsDao.insertTransaction(
      TransactionDto.fromEntity(tx).toCompanion(),
    );
  }

  @override
  Future<void> updateTransaction(TransactionEntity tx) async {
    await db.transactionsDao.updateTransaction(
      TransactionDto.fromEntity(tx).toCompanion(),
    );
  }

  @override
  Future<void> deleteTransaction(int id) async {
    await db.transactionsDao.deleteTransaction(id);
  }

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final rows = await db.transactionsDao.getTransactions();
    return rows
    .map((row) => TransactionDto.fromRow(row).toEntity())
    .toList();
  }

  @override
 @override
Future<TransactionEntity> getTransactionById(int id) async {
  final row = await db.transactionsDao.getTransactionById(id);
  if (row == null) throw Exception("Transaction not found");
  return TransactionDto.fromRow(row).toEntity();
}

}
