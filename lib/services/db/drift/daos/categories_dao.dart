import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/categories_table.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [CategoriesTable])
class CategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(AppDatabase db) : super(db);

  Future<int> insertCategory(CategoriesTableCompanion data) =>
      into(categoriesTable).insert(data);

  Future<bool> updateCategory(CategoriesTableCompanion data) =>
      update(categoriesTable).replace(data);

  Future<int> deleteCategory(int id) =>
      (delete(categoriesTable)..where((c) => c.id.equals(id))).go();

  Future<List<CategoriesTableData>> getCategories() =>
      select(categoriesTable).get();
}
