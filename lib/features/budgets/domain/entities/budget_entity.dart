import 'package:equatable/equatable.dart';

class BudgetEntity extends Equatable {
  final int? id;
  final int categoryId;
  final double limitAmount;
  final int month; // YYYYMM
  final double spentAmount; // computed at runtime

  const BudgetEntity({
    this.id,
    required this.categoryId,
    required this.limitAmount,
    required this.month,
    this.spentAmount = 0.0,
  });

  BudgetEntity copyWith({
    int? id,
    int? categoryId,
    double? limitAmount,
    int? month,
    double? spentAmount,
  }) {
    return BudgetEntity(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      limitAmount: limitAmount ?? this.limitAmount,
      month: month ?? this.month,
      spentAmount: spentAmount ?? this.spentAmount,
    );
  }

  BudgetEntity copyWithSpent(double spent) {
    return copyWith(spentAmount: spent);
  }

  double get remaining => limitAmount - spentAmount;

  /// Percentage used (0..100). If limit is 0 returns 0 to avoid divide-by-zero.
  double get usedPercent {
    if (limitAmount == 0) return 0.0;
    return (spentAmount / limitAmount) * 100;
  }

  @override
  List<Object?> get props => [
        id,
        categoryId,
        limitAmount,
        month,
        spentAmount,
      ];
}
