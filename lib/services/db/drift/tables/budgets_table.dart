import 'package:budget_tracker/services/db/drift/tables/categories_table.dart';
import 'package:drift/drift.dart';

class Budgets extends Table {
  IntColumn get id => integer().autoIncrement()();

  // category this budget belongs to
  IntColumn get categoryId => integer()();

  // monthly limit amount (₹)
  RealColumn get limitAmount => real()();

  // store month as YYYYMM (ex: 202503)
  IntColumn get month => integer()();
}