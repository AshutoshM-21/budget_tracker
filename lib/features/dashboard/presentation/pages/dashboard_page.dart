import 'package:budget_tracker/app/di/injector.dart';
import 'package:budget_tracker/features/categories/presentation/pages/categories_page.dart';
import 'package:budget_tracker/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:budget_tracker/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:budget_tracker/features/dashboard/presentation/widgets/recent_transactions_list.dart';
import 'package:budget_tracker/features/dashboard/presentation/widgets/spend_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DashboardBloc>()..add(LoadDashboard()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CategoryListPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text("Error: ${state.error}"));
          }

          if (state.summary == null) {
            return const Center(child: Text("No data"));
          }

          final summary = state.summary!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 💰 Main balance card
                BalanceCard(summary: summary),
                const SizedBox(height: 24),

                // 📊 Budget usage summary
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Budget Overview",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: summary.overallUsage / 100,
                          minHeight: 10,
                          backgroundColor: Colors.grey[300],
                          color: _getUsageColor(summary.overallUsage),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Used ₹${summary.totalSpent.toStringAsFixed(0)} "
                          "of ₹${summary.totalLimit.toStringAsFixed(0)} "
                          "(${summary.overallUsage.toStringAsFixed(1)}%)",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 🧾 Spend by category chart
                SpendChart(data: state.spendByCategory),
                const SizedBox(height: 24),

                // 📅 Recent transactions
                RecentTransactionsList(data: state.recentTransactions),
              ],
            ),
          );
        },
      ),
    );
  }

  // ✅ Helper to color budget progress
  Color _getUsageColor(double percent) {
    if (percent < 60) return Colors.green;
    if (percent < 85) return Colors.orange;
    return Colors.red;
  }
}
