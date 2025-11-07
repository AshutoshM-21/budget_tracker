import 'package:budget_tracker/services/db/drift/app_database.dart';
import 'package:drift/drift.dart';

import '../../domain/entities/budget_entity.dart';

class BudgetDto {
  final int? id;
  final int categoryId;
  final double limitAmount;
  final double spentAmount;

  BudgetDto({
    this.id,
    required this.categoryId,
    required this.limitAmount,
    required this.spentAmount,
  });

  factory BudgetDto.fromEntity(BudgetEntity entity) {
    return BudgetDto(
      id: entity.id,
      categoryId: entity.categoryId,
      limitAmount: entity.limitAmount,
      spentAmount: entity.spentAmount,
    );
  }

  factory BudgetDto.fromRow(BudgetsTableData row) {
    return BudgetDto(
      id: row.id,
      categoryId: row.categoryId,
      limitAmount: row.limitAmount,
      spentAmount: row.spentAmount,
    );
  }

  BudgetsTableCompanion toCompanion() {
    return BudgetsTableCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      categoryId: Value(categoryId),
      limitAmount: Value(limitAmount),
      spentAmount: Value(spentAmount),
    );
  }

  BudgetEntity toEntity() {
    return BudgetEntity(
      id: id,
      categoryId: categoryId,
      limitAmount: limitAmount,
      spentAmount: spentAmount,
    );
  }
}
