import 'package:budget_tracker/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetSpendByCategory {
  final DashboardRepository repo;

  GetSpendByCategory(this.repo);

  Future<List<Map<String, dynamic>>> call() => repo.getSpendByCategory();
}