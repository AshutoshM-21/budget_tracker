import 'package:budget_tracker/services/db/drift/app_database.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/category_dto.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final AppDatabase db;

  CategoryRepositoryImpl(this.db);

  @override
  Future<void> addCategory(CategoryEntity category) async {
    await db.categoriesDao.insertCategory(
      CategoryDto.fromEntity(category).toCompanion(),
    );
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    await db.categoriesDao.updateCategory(
      CategoryDto.fromEntity(category).toCompanion(),
    );
  }

  @override
  Future<void> deleteCategory(int id) async {
    await db.categoriesDao.deleteCategory(id);
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final rows = await db.categoriesDao.getCategories();
    return rows.map((row) => CategoryDto.fromRow(row).toEntity()).toList();
  }
}
