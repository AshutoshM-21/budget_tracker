import 'package:budget_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';

class CategoriesState extends Equatable {
  final bool loading;
  final List<CategoryEntity> categories;
  final String? error;

  const CategoriesState({
    required this.loading,
    required this.categories,
    required this.error,
  });

  factory CategoriesState.initial() => const CategoriesState(
        loading: false,
        categories: [],
        error: null,
      );

  CategoriesState copyWith({
    bool? loading,
    List<CategoryEntity>? categories,
    String? error,
  }) {
    return CategoriesState(
      loading: loading ?? this.loading,
      categories: categories ?? this.categories,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, categories, error];
}