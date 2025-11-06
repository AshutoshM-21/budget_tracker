import 'package:budget_tracker/features/categories/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<void> addCategory(CategoryEntity category);
  Future<void> updateCategory(CategoryEntity category);
  Future<void> deleteCategory(int id);
  Future<List<CategoryEntity>> getCategories();
}