import 'package:budget_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:budget_tracker/features/categories/domain/repositories/category_repository.dart';

class UpdateCategory {
  final CategoryRepository repo;

  UpdateCategory(this.repo);

  Future<void> call(CategoryEntity cat) => repo.updateCategory(cat);
}