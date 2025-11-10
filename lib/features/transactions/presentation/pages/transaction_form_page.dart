import 'package:budget_tracker/app/di/injector.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/form/transaction_form_bloc.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/form/transaction_form_event.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/form/transaction_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionFormPage extends StatelessWidget {
  final int? editingId;

  const TransactionFormPage({super.key, this.editingId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<TransactionFormBloc>();
        if (editingId != null) {
          bloc.add(LoadTransactionForEdit(editingId!));
        }
        return bloc;
      },
      child: const _FormView(),
    );
  }
}

class _FormView extends StatelessWidget {
  const _FormView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transaction")),
      body: BlocConsumer<TransactionFormBloc, TransactionFormState>(
        listener: (context, state) {
          if (state.success) {
            Navigator.pop(context);
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        builder: (context, state) {
          if (state.loading && !state.isEditing) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Title"),
                  onChanged: (v) => context.read<TransactionFormBloc>().add(UpdateTitle(v)),
                  controller: TextEditingController(text: state.title),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => context.read<TransactionFormBloc>().add(UpdateAmount(v)),
                  controller: TextEditingController(text: state.amount),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text("Is Expense: "),
                    Switch(
                      value: state.isExpense,
                      onChanged: (v) =>
                          context.read<TransactionFormBloc>().add(UpdateIsExpense(v)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<TransactionFormBloc>().add(SubmitTransaction());
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}