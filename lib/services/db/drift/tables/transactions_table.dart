import 'package:drift/drift.dart';


class TransactionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get amount => integer()();
  DateTimeColumn get date => dateTime()();
  IntColumn get categoryId => integer()();
  BoolColumn get isExpense => boolean()();
}