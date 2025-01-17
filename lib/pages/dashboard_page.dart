import 'package:flutter/material.dart';
import 'package:penny_pilot/widgets/HeroCard_dashboard.dart';
import 'package:penny_pilot/widgets/RecentTransactionCard.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                HeroCard(),
                SizedBox(height: 10),
                TransactionCard(),
              ],
            ),
          ),
        ),
      );
    
  }
}
