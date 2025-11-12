import 'package:budget_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';

class CategoriesState extends Equatable {
  final bool loading;
  final List<CategoryEntity> list;
  final String? error;

  const CategoriesState({
    required this.loading,
    required this.list,
    required this.error,
  });

  factory CategoriesState.initial() =>
      const CategoriesState(loading: false, list: [], error: null);

  CategoriesState copyWith({
    bool? loading,
    List<CategoryEntity>? list,
    String? error,
  }) {
    return CategoriesState(
      loading: loading ?? this.loading,
      list: list ?? this.list,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, list, error];
}