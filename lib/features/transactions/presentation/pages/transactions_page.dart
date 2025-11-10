import 'package:budget_tracker/app/di/injector.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/list/transactions_list_bloc.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/list/transactions_list_event.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/list/transactions_list_state.dart';
import 'package:budget_tracker/features/transactions/presentation/pages/transaction_form_page.dart';
import 'package:budget_tracker/features/transactions/presentation/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TransactionsListBloc>()..add(LoadTransactionsList()),
      child: const _TransactionsView(),
    );
  }
}

class _TransactionsView extends StatelessWidget {
  const _TransactionsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Transactions")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TransactionFormPage()),
          ).then((_) {
            context.read<TransactionsListBloc>().add(LoadTransactionsList());
          });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TransactionsListBloc, TransactionsListState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text("Error: ${state.error}"));
          }

          if (state.transactions.isEmpty) {
            return const Center(child: Text("No transactions yet"));
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<TransactionsListBloc>().add(LoadTransactionsList());
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                return TransactionTile(
                  tx: state.transactions[index],
                  onDelete: () {
                    context
                        .read<TransactionsListBloc>()
                        .add(DeleteTransactionEvent(state.transactions[index].id!));
                  },
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TransactionFormPage(
                          editingId: state.transactions[index].id!,
                        ),
                      ),
                    ).then((_) {
                      context.read<TransactionsListBloc>().add(LoadTransactionsList());
                    });
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}