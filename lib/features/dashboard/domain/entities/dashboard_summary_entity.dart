
import 'package:equatable/equatable.dart';

class DashboardSummaryEntity extends Equatable {
  final double totalBalance;
  final double totalIncome;
  final double totalExpense;

  const DashboardSummaryEntity({
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  List<Object?> get props => [totalBalance, totalIncome, totalExpense];
}
