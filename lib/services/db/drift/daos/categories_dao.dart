import 'package:budget_tracker/services/db/drift/tables/categories_table.dart';
import 'package:drift/drift.dart';
import '../app_database.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [CategoriesTable])
class CategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(AppDatabase db) : super(db);

  // ✅ GET ALL
  Future<List<CategoriesTableData>> getAllCategories() {
    return select(categoriesTable).get();
  }

  // ✅ INSERT
  Future<int> insertCategory(CategoriesTableCompanion cat) {
    return into(categoriesTable).insert(cat);
  }

  // ✅ UPDATE
  Future<bool> updateCategory(CategoriesTableCompanion cat) {
    return update(categoriesTable).replace(cat);
  }

  // ✅ DELETE
  Future<int> deleteCategory(int id) {
    return (delete(categoriesTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
