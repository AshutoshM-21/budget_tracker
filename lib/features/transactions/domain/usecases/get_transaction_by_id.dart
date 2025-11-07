import 'package:budget_tracker/features/transactions/domain/entities/transaction_entity.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';

class GetTransactionById {
  final TransactionRepository repo;

  GetTransactionById(this.repo);

  Future<TransactionEntity?> call(int id) {
    return repo.getTransactionById(id);
  }
}