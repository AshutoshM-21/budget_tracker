
import 'package:budget_tracker/services/db/drift/daos/categories_dao.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/category_dto.dart';
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoriesDao dao;

  CategoryRepositoryImpl(this.dao);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final list = await dao.getAllCategories();
    return list.map((row) => CategoryDto.fromTable(row).toEntity()).toList();
  }

  @override
  Future<void> addCategory(CategoryEntity category) async {
    final dto = CategoryDto(
      name: category.name,
      color: category.color,
      isExpense: category.isExpense,
    );
    await dao.insertCategory(dto.toCompanion());
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    final dto = CategoryDto(
      id: category.id,
      name: category.name,
      color: category.color,
      isExpense: category.isExpense,
    );
    await dao.updateCategory(dto.toCompanion());
  }

  @override
  Future<void> deleteCategory(int id) {
    return dao.deleteCategory(id);
  }
}