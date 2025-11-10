import 'package:budget_tracker/app/di/injector.dart';
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
      child: DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BalanceCard(summary: state.summary!),
                const SizedBox(height: 20),
                // SpendChart(data: state.spendByCategory),
                const SizedBox(height: 20),
                // RecentTransactionsList(data: state.recentTransactions),
              ],
            ),
          );
        },
      ),
    );
  }
}