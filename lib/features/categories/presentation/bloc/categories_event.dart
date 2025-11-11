import 'package:budget_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoriesEvent {}

class AddCategoryEvent extends CategoriesEvent {
  final CategoryEntity category;
  AddCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class UpdateCategoryEvent extends CategoriesEvent {
  final CategoryEntity category;
  UpdateCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class DeleteCategoryEvent extends CategoriesEvent {
  final int id;
  DeleteCategoryEvent(this.id);

  @override
  List<Object?> get props => [id];
}