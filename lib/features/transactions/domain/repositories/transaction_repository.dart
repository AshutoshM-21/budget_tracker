import 'package:budget_tracker/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionEntity transaction);
  Future<void> updateTransaction(TransactionEntity transaction);
  Future<void> deleteTransaction(int id);
  Future<List<TransactionEntity>> getTransactions();  
  Future<TransactionEntity> getTransactionById(int id);
}