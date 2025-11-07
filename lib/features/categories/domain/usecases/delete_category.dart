import 'package:budget_tracker/features/categories/domain/repositories/category_repository.dart';

class DeleteCategory {
  final CategoryRepository repo;

  DeleteCategory(this.repo);

  Future<void> call(int id) => repo.deleteCategory(id);
}