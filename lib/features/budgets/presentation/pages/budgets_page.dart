import 'package:budget_tracker/app/di/injector.dart';

import 'package:budget_tracker/features/budgets/presentation/bloc/budgets_bloc.dart';
import 'package:budget_tracker/features/budgets/presentation/bloc/budgets_event.dart';
import 'package:budget_tracker/features/budgets/presentation/bloc/budgets_state.dart';
import 'package:budget_tracker/features/budgets/presentation/pages/budget_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetListPage extends StatelessWidget {
  const BudgetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BudgetBloc>()..add(LoadBudgets()),
      child: const _BudgetListView(),
    );
  }
}

class _BudgetListView extends StatelessWidget {
  const _BudgetListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BudgetFormPage()),
          );
          context.read<BudgetBloc>().add(LoadBudgets());
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          if (state.budgets.isEmpty) {
            return const Center(child: Text('No budgets found'));
          }

          return ListView.builder(
            itemCount: state.budgets.length,
            itemBuilder: (context, index) {
              final b = state.budgets[index];
              final percent = b.usedPercent.clamp(0, 100);
              final color = percent >= 90
                  ? Colors.red
                  : percent >= 75
                      ? Colors.orange
                      : Colors.green;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Category: ${b.categoryId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '₹${b.spentAmount.toStringAsFixed(2)} / ₹${b.limitAmount.toStringAsFixed(2)}'),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: b.usedPercent / 100,
                        color: color,
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<BudgetBloc>().add(DeleteBudgetEvent(b.id!));
                    },
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BudgetFormPage(editingBudget: b),
                      ),
                    );
                    context.read<BudgetBloc>().add(LoadBudgets());
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
