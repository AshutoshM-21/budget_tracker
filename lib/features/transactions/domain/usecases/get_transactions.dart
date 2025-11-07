import 'package:budget_tracker/features/transactions/domain/entities/transaction_entity.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repo;

  GetTransactions(this.repo);

  Future<List<TransactionEntity>> call() {
    return repo.getTransactions();
  }
}