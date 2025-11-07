import 'package:budget_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:budget_tracker/features/categories/domain/repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repo;

  GetCategories(this.repo);

  Future<List<CategoryEntity>> call() => repo.getCategories();
}