import 'package:budget_tracker/services/db/drift/tables/categories_table.dart';
import 'package:drift/drift.dart';

class BudgetsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(CategoriesTable, #id)();
  RealColumn get limitAmount => real()();
  RealColumn get spentAmount => real().withDefault(const Constant(0))();
}
