import 'package:budget_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:budget_tracker/services/db/drift/app_database.dart';
import 'package:drift/drift.dart';

class CategoryDto {
  final int? id;
  final String name;
  final int color;
  final bool isExpense;

  CategoryDto({
    this.id,
    required this.name,
    required this.color,
    required this.isExpense,
  });

  factory CategoryDto.fromTable(CategoriesTableData row) {
    return CategoryDto(
      id: row.id,
      name: row.name,
      color: row.color,
      isExpense: row.isExpense,
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      color: color,
      isExpense: isExpense,
    );
  }

  CategoriesTableCompanion toCompanion() {
    return CategoriesTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      color: Value(color),
      isExpense: Value(isExpense),
    );
  }
}