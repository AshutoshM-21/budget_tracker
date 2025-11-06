import 'package:budget_tracker/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:budget_tracker/features/dashboard/presentation/widgets/recent_transactions_list.dart';
import 'package:budget_tracker/features/dashboard/presentation/widgets/spend_chart.dart';
import 'package:flutter/material.dart';

class DashboardPage
 extends StatelessWidget {
  const DashboardPage
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceCard(),
            SizedBox(height: 12),
            SpendChart(),
            SizedBox(height: 12),
            RecentTransactionsList(),
          ],
        ),
      ),
    );
  }
}