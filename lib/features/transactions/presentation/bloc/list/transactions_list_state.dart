import 'package:budget_tracker/features/transactions/domain/entities/transaction_entity.dart';
import 'package:equatable/equatable.dart';

class TransactionsListState extends Equatable {
  final bool loading;
  final List<TransactionEntity> transactions;
  final String? error;
  TransactionsListState({
    required this.loading,
    required this.transactions,
    required this.error,
  });

  factory TransactionsListState.initial() =>
      TransactionsListState(loading: false, transactions: [], error: null);

  TransactionsListState copyWith({
  bool? loading,
  List<TransactionEntity>? transactions,
  String? error,
}) {
  return TransactionsListState(
    loading: loading ?? this.loading,
    transactions: transactions ?? this.transactions,
    error: error,
  );
}

  @override
  List<Object?> get props => [loading, transactions, error];
}
