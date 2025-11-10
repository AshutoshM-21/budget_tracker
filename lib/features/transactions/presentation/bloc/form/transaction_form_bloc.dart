import 'package:budget_tracker/features/transactions/presentation/bloc/form/transaction_form_event.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/form/transaction_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionFormBloc extends Bloc<TransactionFormEvent, TransactionFormState>{
  TransactionFormBloc(super.initialState) {
    on<UpdateTitle>((event, emit) {
      emit(state.copyWith(title: event.value));
    });
  }

}