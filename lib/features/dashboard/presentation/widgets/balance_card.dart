import 'package:budget_tracker/features/dashboard/domain/entities/dashboard_summary_entity.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required DashboardSummaryEntity summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text("Total Balance",
          style: TextStyle(color: Colors.white,fontSize: 20),
          ),
          SizedBox(height: 12,),
          Text(" ₹ 100",
          style: TextStyle(color: Colors.white,fontSize: 30),
          ),
        ],
      ),
    );
  }
}