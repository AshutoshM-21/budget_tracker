import 'package:budget_tracker/app/di/injector.dart';
import 'package:budget_tracker/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:budget_tracker/features/categories/presentation/bloc/categories_event.dart';
import 'package:budget_tracker/features/categories/presentation/bloc/categories_state.dart';
import 'package:budget_tracker/features/categories/presentation/pages/category_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoriesBloc>()..add(LoadCategories()),
      child: const _CategoryListView(),
    );
  }
}

class _CategoryListView extends StatelessWidget {
  const _CategoryListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CategoryFormPage()),
          ).then((_) {
            context.read<CategoriesBloc>().add(LoadCategories());
          });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          if (state.list.isEmpty) {
            return const Center(child: Text("No categories yet"));
          }

          return ListView.builder(
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              final cat = state.list[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(cat.color),
                  ),
                  title: Text(cat.name),
                  subtitle: Text(cat.isExpense ? "Expense" : "Income"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryFormPage(editingCategory: cat),
                      ),
                    ).then((_) {
                      context.read<CategoriesBloc>().add(LoadCategories());
                    });
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context
                          .read<CategoriesBloc>()
                          .add(DeleteCategoryEvent(cat.id!));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
