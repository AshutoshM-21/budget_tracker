import 'package:budget_tracker/features/transactions/domain/entities/transaction_entity.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';

class UpdateTransaction {
  final TransactionRepository repo;

  UpdateTransaction(this.repo);

  Future<void> call(TransactionEntity tx) async {
    return repo.updateTransaction(tx);
  }
}