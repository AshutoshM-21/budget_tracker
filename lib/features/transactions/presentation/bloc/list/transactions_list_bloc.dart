import 'dart:async';

import 'package:budget_tracker/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/get_transactions.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/list/transactions_list_event.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/list/transactions_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsListBloc extends Bloc<TransactionsListEvent, TransactionsListState> {
 final GetTransactions getTransactions;
 final DeleteTransaction deleteTransaction;

 TransactionsListBloc({
    required this.getTransactions,
    required this.deleteTransaction,
  }) : super(TransactionsListState.initial()) {
     on<LoadTransactionsList>(_loadTransactions);
    on<DeleteTransactionEvent>(_deleteTransaction);
  }

 

  

  FutureOr<void> _loadTransactions(LoadTransactionsList event, Emitter<TransactionsListState> emit) async{
    emit(state.copyWith(loading: true,error: null));

    try {
      final list = await getTransactions();
      emit(state.copyWith(loading: false,transactions: list));
    } catch (e) {
      emit(state.copyWith(loading: false,error: e.toString()));
    }
  }

  FutureOr<void> _deleteTransaction(DeleteTransactionEvent event, Emitter<TransactionsListState> emit) async{
    try {
      await deleteTransaction(event.id);
      add(LoadTransactionsList());
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
