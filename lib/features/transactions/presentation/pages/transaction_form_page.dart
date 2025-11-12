import 'package:budget_tracker/app/di/injector.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/form/transaction_form_bloc.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/form/transaction_form_event.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/form/transaction_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionFormPage extends StatelessWidget {
  final int? editingId;

  const TransactionFormPage({super.key, this.editingId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<TransactionFormBloc>();

        // ✅ Load categories for dropdown
        bloc.add(LoadCategoriesForForm());

        // ✅ Load transaction for edit mode
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
                // ✅ Title
                TextField(
                  decoration: const InputDecoration(labelText: "Title"),
                  controller: TextEditingController(text: state.title),
                  onChanged: (v) => context.read<TransactionFormBloc>().add(UpdateTitle(v)),
                ),

                // ✅ Amount
                TextField(
                  decoration: const InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(
                    text: state.amount.toString(),
                  ),
                  onChanged: (v) {
                    final value = double.tryParse(v) ?? 0.0;
                    context.read<TransactionFormBloc>().add(UpdateAmount(value));
                  },
                ),

                const SizedBox(height: 16),

                // ✅ Category Dropdown
                BlocBuilder<TransactionFormBloc, TransactionFormState>(
                  builder: (context, state) {
                    if (state.categories.isEmpty) {
                      return const Text("Loading categories...");
                    }

                    return DropdownButtonFormField<int>(
                      value: state.categoryId,
                      decoration: const InputDecoration(labelText: "Category"),
                      items: state.categories.map((cat) {
                        return DropdownMenuItem<int>(
                          value: cat.id,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 8,
                                backgroundColor: Color(cat.color),
                              ),
                              const SizedBox(width: 10),
                              Text(cat.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<TransactionFormBloc>()
                              .add(UpdateCategory(value));
                        }
                      },
                    );
                  },
                ),

                const SizedBox(height: 16),

                // ✅ Expense / Income Switch
                Row(
                  children: [
                    const Text("Is Expense: "),
                    Switch(
                      value: state.isExpense,
                      onChanged: (v) => context
                          .read<TransactionFormBloc>()
                          .add(UpdateIsExpense(v)),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ✅ Save Button
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<TransactionFormBloc>()
                        .add(SubmitTransaction());
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
