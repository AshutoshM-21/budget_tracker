import 'package:budget_tracker/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetRecentTransactions {
  final DashboardRepository repo;

  GetRecentTransactions(this.repo);

  Future<List<dynamic>> call() => repo.getRecentTransactions();
}