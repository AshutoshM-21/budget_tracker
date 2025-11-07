import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';

class DeleteTransaction {
  final TransactionRepository repo;

  DeleteTransaction(this.repo);

  Future<void> call(int id) async {
    return repo.deleteTransaction(id);
  }
}