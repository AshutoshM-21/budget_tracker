import 'package:budget_tracker/features/budgets/domain/entities/budget_entity.dart';
import 'package:budget_tracker/features/budgets/presentation/bloc/budgets_bloc.dart';
import 'package:budget_tracker/features/budgets/presentation/bloc/budgets_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetFormPage extends StatefulWidget {
  final BudgetEntity? editingBudget;

  const BudgetFormPage({super.key, this.editingBudget});

  @override
  State<BudgetFormPage> createState() => _BudgetFormPageState();
}

class _BudgetFormPageState extends State<BudgetFormPage> {
  late TextEditingController limitCtrl;
  late TextEditingController monthCtrl;
  late TextEditingController categoryCtrl;

  @override
  void initState() {
    super.initState();
    final b = widget.editingBudget;
    limitCtrl = TextEditingController(
        text: b != null ? b.limitAmount.toString() : '');
    monthCtrl = TextEditingController(text: b?.month.toString() ?? '');
    categoryCtrl = TextEditingController(
        text: b != null ? b.categoryId.toString() : '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.editingBudget == null ? 'Add Budget' : 'Edit Budget')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Category ID'),
              keyboardType: TextInputType.number,
              controller: categoryCtrl,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Limit Amount'),
              keyboardType: TextInputType.number,
              controller: limitCtrl,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Month (YYYYMM)'),
              keyboardType: TextInputType.number,
              controller: monthCtrl,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final categoryId = int.tryParse(categoryCtrl.text) ?? 0;
                final limit = double.tryParse(limitCtrl.text) ?? 0.0;
                final month = int.tryParse(monthCtrl.text) ?? 0;

                final budget = BudgetEntity(
                  id: widget.editingBudget?.id,
                  categoryId: categoryId,
                  limitAmount: limit,
                  month: month,
                );

                if (widget.editingBudget == null) {
                  context.read<BudgetBloc>().add(AddBudgetEvent(budget));
                } else {
                  context.read<BudgetBloc>().add(UpdateBudgetEvent(budget));
                }

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
