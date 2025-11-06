import 'package:budget_tracker/features/dashboard/domain/entities/dashboard_summary_entity.dart';

abstract class DashboardRepository {
  Future<DashboardSummaryEntity> getDashboardSummary();
  Future<List<Map<String, dynamic>>> getSpendByCategory(); // simplified for now
  Future<List<dynamic>> getRecentTransactions(); // will refine later
}
