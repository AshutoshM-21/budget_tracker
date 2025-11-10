import 'package:equatable/equatable.dart';

abstract class TransactionsListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTransactionsList extends TransactionsListEvent {}

// Delete a transaction
class DeleteTransactionEvent extends TransactionsListEvent {
  final int id;

  DeleteTransactionEvent(this.id);

  @override
  List<Object?> get props => [id];
}


