import 'package:flutter/material.dart';
import 'package:penny_pilot/database/db_txns.dart';
import 'package:penny_pilot/helper/helper_funcs.dart';

class HeroCard extends StatefulWidget {
  const HeroCard({super.key});

  @override
  State<HeroCard> createState() => _HeroCardState();
}

class _HeroCardState extends State<HeroCard> {
  late Future<double> totalIncomeFuture;
  late Future<double> totalExpenseFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future objects to fetch data
    totalIncomeFuture = DatabaseTxn.instance.getTotalIncome(getCurrentUserEmail()!);
    totalExpenseFuture = DatabaseTxn.instance.getTotalExpense(getCurrentUserEmail()!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Total Balance",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            height: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        
        // FutureBuilder for total balance (Income - Expense)
        FutureBuilder<double>(
          future: totalIncomeFuture,
          builder: (context, incomeSnapshot) {
            if (incomeSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (incomeSnapshot.hasError) {
              return Text('Error: ${incomeSnapshot.error}');
            }
            double totalIncome = incomeSnapshot.data ?? 0.0;

            return FutureBuilder<double>(
              future: totalExpenseFuture,
              builder: (context, expenseSnapshot) {
                if (expenseSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (expenseSnapshot.hasError) {
                  return Text('Error: ${expenseSnapshot.error}');
                }
                double totalExpense = expenseSnapshot.data ?? 0.0;

                // Calculate total balance (Income - Expense)
                double totalBalance = totalIncome - totalExpense;

                return Text(
                  "₹ ${totalBalance.toStringAsFixed(2)}", // Display total balance with 2 decimal points
                  style: TextStyle(
                    fontSize: 44,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            );
          },
        ),
        Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                
                // Income Card
                FutureBuilder<double>(
                  future: totalIncomeFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    double incomeAmount = snapshot.data ?? 0.0;
                    return CardOne(
                      color: Colors.green,
                      title: 'Income',
                      icon: Icons.arrow_upward,
                      amount: incomeAmount,
                    );
                  },
                ),
                SizedBox(width: 10),
                
                // Expense Card
                FutureBuilder<double>(
                  future: totalExpenseFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    double expenseAmount = snapshot.data ?? 0.0;
                    return CardOne(
                      color: Colors.red,
                      title: 'Expenses',
                      icon: Icons.arrow_downward,
                      amount: expenseAmount,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardOne extends StatelessWidget {
  const CardOne({
    super.key,
    required this.color,
    required this.title,
    required this.icon,
    required this.amount,
  });

  final Color color;
  final String title;
  final IconData icon;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: color, fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Icon(
                        icon,
                        color: color,
                        size: 24,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.currency_rupee_sharp,
                        color: color,
                        size: 20,
                      ),
                      Text(
                        "$amount", // Display the dynamic amount
                        style: TextStyle(color: color, fontSize: 24),
                      ),
                    ],
                  )
                ],
              ),
        ),
      ),
    );
  }
}
