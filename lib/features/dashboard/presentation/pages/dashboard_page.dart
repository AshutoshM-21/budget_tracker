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
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.loading){
          return const Center(child: CircularProgressIndicator());
        }
        if(state.error!= null){
          return Center(child: Text("Error: ${state.error}"));
        }
        if(state.summary ==null){
          return Center(child: Text("NO DATA"));
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Dashboard')),
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
      },
    );
  }
}
