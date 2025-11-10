import 'dart:ui';

import 'package:budget_tracker/features/transactions/domain/entities/transaction_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionTile extends StatelessWidget {
  final TransactionEntity tx;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TransactionTile({
    super.key,
    required this.tx,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onEdit,
        title: Text(tx.title),
        subtitle: Text(
          "${tx.date.day}-${tx.date.month}-${tx.date.year}",
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${tx.isExpense ? "-" : "+"} ₹${tx.amount}",
              style: TextStyle(
                color: tx.isExpense ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}