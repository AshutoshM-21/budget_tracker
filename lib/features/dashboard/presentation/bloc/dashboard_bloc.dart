import 'package:bloc/bloc.dart';
import 'package:budget_tracker/features/dashboard/domain/entities/dashboard_summary_entity.dart';
import 'package:budget_tracker/features/dashboard/domain/usecases/get_dashboard_summary.dart';
import 'package:budget_tracker/features/dashboard/domain/usecases/get_recent_transactions.dart';
import 'package:budget_tracker/features/dashboard/domain/usecases/get_spend_by_category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardSummary getSummary;
  final GetRecentTransactions getRecent;
  final GetSpendByCategory getSpend;

  DashboardBloc({
    required this.getSummary,
    required this.getRecent,
    required this.getSpend,
  }) : super(DashboardState.initial()) {
    on<LoadDashboard>(_loadDashboard);
  }

  Future<void> _loadDashboard(LoadDashboard event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final summary = await getSummary();
      final recent = await getRecent();
      final spend = await getSpend();

      emit(
        state.copyWith(
          loading: false,
          summary: summary,
          recentTransactions: recent,
          spendByCategory: spend,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}