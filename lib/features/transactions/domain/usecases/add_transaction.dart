import 'package:budget_tracker/features/transactions/domain/entities/transaction_entity.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';

class AddTransaction {
  final TransactionRepository repo;

  AddTransaction(this.repo);

  Future<void> call(TransactionEntity tx) async {
    return repo.addTransaction(tx);
  }
}
