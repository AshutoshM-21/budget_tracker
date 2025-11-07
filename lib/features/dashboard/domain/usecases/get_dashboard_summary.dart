import 'package:budget_tracker/features/dashboard/domain/entities/dashboard_summary_entity.dart';
import 'package:budget_tracker/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardSummary {
  final DashboardRepository repo;

  GetDashboardSummary(this.repo);

  Future<DashboardSummaryEntity> call() => repo.getDashboardSummary();
}