import 'package:budget_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:budget_tracker/features/categories/domain/repositories/category_repository.dart';

class AddCategory {
  final CategoryRepository repo;

  AddCategory(this.repo);

  Future<void> call(CategoryEntity cat) => repo.addCategory(cat);
}