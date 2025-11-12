import 'package:drift/drift.dart';
import 'package:budget_tracker/features/budgets/domain/entities/budget_entity.dart';
import 'package:budget_tracker/services/db/drift/app_database.dart';

class BudgetDto {
  final int? id;
  final int categoryId;
  final double limitAmount;
  final int month;

  // This is runtime only, not stored in DB
  final double spentAmount;

  BudgetDto({
    this.id,
    required this.categoryId,
    required this.limitAmount,
    required this.month,
    this.spentAmount = 0.0,
  });

  // ✅ From Drift row
  factory BudgetDto.fromRow(Budget row) {
    return BudgetDto(
      id: row.id,
      categoryId: row.categoryId,
      limitAmount: row.limitAmount,
      month: row.month,
    );
  }

  // ✅ From Domain Entity
  factory BudgetDto.fromEntity(BudgetEntity entity) {
    return BudgetDto(
      id: entity.id,
      categoryId: entity.categoryId,
      limitAmount: entity.limitAmount,
      month: entity.month,
      spentAmount: entity.spentAmount,
    );
  }

  // ✅ Convert to Drift Companion for insert/update
  BudgetsCompanion toCompanion() {
    return BudgetsCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      categoryId: Value(categoryId),
      limitAmount: Value(limitAmount),
      month: Value(month),
    );
  }

  // ✅ Convert to Domain Entity
  BudgetEntity toEntity({double spent = 0.0}) {
    return BudgetEntity(
      id: id,
      categoryId: categoryId,
      limitAmount: limitAmount,
      month: month,
      spentAmount: spentAmount == 0.0 ? spent : spentAmount,
    );
  }
}
