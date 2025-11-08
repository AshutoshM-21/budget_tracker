part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final bool loading;
  final DashboardSummaryEntity? summary;
  final List<Map<String, dynamic>> spendByCategory;
  final List<dynamic> recentTransactions;
  final String? error;

  const DashboardState({
    required this.loading,
    required this.summary,
    required this.spendByCategory,
    required this.recentTransactions,
    required this.error,
  });

  factory DashboardState.initial() => const DashboardState(
        loading: false,
        summary: null,
        spendByCategory: [],
        recentTransactions: [],
        error: null,
      );

  DashboardState copyWith({
    bool? loading,
    DashboardSummaryEntity? summary,
    List<Map<String, dynamic>>? spendByCategory,
    List<dynamic>? recentTransactions,
    String? error,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      summary: summary ?? this.summary,
      spendByCategory: spendByCategory ?? this.spendByCategory,
      recentTransactions: recentTransactions ?? this.recentTransactions,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [loading, summary, spendByCategory, recentTransactions, error];
}