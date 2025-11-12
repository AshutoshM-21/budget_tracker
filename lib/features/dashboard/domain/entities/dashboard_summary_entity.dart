import 'package:equatable/equatable.dart';

class DashboardSummaryEntity extends Equatable {
  final double totalBalance;
  final double totalIncome;
  final double totalExpense;

  // ✅ New budget-related fields
  final double totalLimit;
  final double totalSpent;
  final double overallUsage;

  const DashboardSummaryEntity({
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
    this.totalLimit = 0.0,
    this.totalSpent = 0.0,
    this.overallUsage = 0.0,
  });

  @override
  List<Object?> get props => [
        totalBalance,
        totalIncome,
        totalExpense,
        totalLimit,
        totalSpent,
        overallUsage,
      ];
}
