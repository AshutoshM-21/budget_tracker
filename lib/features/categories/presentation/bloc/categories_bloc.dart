import 'package:budget_tracker/features/categories/domain/usecases/add_category.dart';
import 'package:budget_tracker/features/categories/domain/usecases/delete_category.dart';
import 'package:budget_tracker/features/categories/domain/usecases/get_categories.dart';
import 'package:budget_tracker/features/categories/presentation/bloc/categories_event.dart';
import 'package:budget_tracker/features/categories/presentation/bloc/categories_state.dart';
import 'package:budget_tracker/features/transactions/presentation/bloc/form/transaction_form_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategories getCategories;
  final AddCategory addCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;

  CategoriesBloc({
    required this.getCategories,
    required this.addCategory,
    required this.updateCategory,
    required this.deleteCategory,
  }) : super(CategoriesState.initial()) {
    on<LoadCategories>(_load);
    on<AddCategoryEvent>(_add);
    on<UpdateCategoryEvent>(_update);
    on<DeleteCategoryEvent>(_delete);
  }

  Future<void> _load(
      LoadCategories event, Emitter<CategoriesState> emit) async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final list = await getCategories();
      emit(state.copyWith(loading: false, categories: list));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _add(
      AddCategoryEvent event, Emitter<CategoriesState> emit) async {
    await addCategory(event.category);
    add(LoadCategories());
  }

  Future<void> _update(
      UpdateCategoryEvent event, Emitter<CategoriesState> emit) async {
    await updateCategory(event.category);
    add(LoadCategories());
  }

  Future<void> _delete(
      DeleteCategoryEvent event, Emitter<CategoriesState> emit) async {
    await deleteCategory(event.id);
    add(LoadCategories());
  }
}