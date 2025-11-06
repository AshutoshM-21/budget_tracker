import 'package:flutter/material.dart';

class RecentTransactionsList extends StatelessWidget {
  const RecentTransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> mockTransactions = [
      {"title": "Groceries", "amount": 450, "isExpense": true},
      {"title": "Salary", "amount": 18000, "isExpense": false},
      {"title": "Electricity Bill", "amount": 1200, "isExpense": true},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Transactions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),

        ...mockTransactions.map(
          (tx) => Card(
            child: ListTile(
              title: Text(tx["title"]),
              trailing: Text(
                "${tx["isExpense"] ? "-" : "+"} ₹${tx["amount"]}",
                style: TextStyle(
                  color: tx["isExpense"] ? Colors.red : Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
