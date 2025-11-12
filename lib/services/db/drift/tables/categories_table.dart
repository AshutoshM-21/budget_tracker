import 'package:drift/drift.dart';

class CategoriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get color => integer()();        // ✅ store color as int
  BoolColumn get isExpense => boolean()();   // ✅ expense/income type
}
