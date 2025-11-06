import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

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