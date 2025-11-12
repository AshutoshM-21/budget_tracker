
import 'package:budget_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:budget_tracker/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:budget_tracker/features/categories/presentation/bloc/categories_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryFormPage extends StatefulWidget {
  final CategoryEntity? editingCategory;

  const CategoryFormPage({super.key, this.editingCategory});

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  late TextEditingController nameCtrl;
  late bool isExpense;
  late int color;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.editingCategory?.name ?? '');
    isExpense = widget.editingCategory?.isExpense ?? true;
    color = widget.editingCategory?.color ?? Colors.blue.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editingCategory == null ? "Add Category" : "Edit Category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Category Name"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text("Type: "),
                Switch(
                  value: isExpense,
                  onChanged: (v) {
                    setState(() {
                      isExpense = v;
                    });
                  },
                ),
                Text(isExpense ? "Expense" : "Income"),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Color: "),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () async {
                    final newColor = await pickColor(context, color);
                    if (newColor != null) {
                      setState(() {
                        color = newColor;
                      });
                    }
                  },
                  child: CircleAvatar(backgroundColor: Color(color), radius: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final cat = CategoryEntity(
                  id: widget.editingCategory?.id,
                  name: nameCtrl.text.trim(),
                  color: color,
                  isExpense: isExpense,
                );

                final bloc = context.read<CategoriesBloc>();

                if (widget.editingCategory == null) {
                  bloc.add(AddCategoryEvent(cat));
                } else {
                  bloc.add(UpdateCategoryEvent(cat));
                }

                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  Future<int?> pickColor(BuildContext context, int currentColor) async {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.brown,
    ];

    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick a Color"),
          content: Wrap(
            spacing: 12,
            children: colors
                .map((c) => GestureDetector(
                      onTap: () => Navigator.pop(context, c.value),
                      child: CircleAvatar(backgroundColor: c, radius: 18),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}