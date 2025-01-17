import 'package:flutter/material.dart';
import 'package:penny_pilot/widgets/HeroCard_dashboard.dart';
import 'package:penny_pilot/widgets/RecentTransactionCard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const title = 'Dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> _refreshData() async {
    // Add your data refreshing logic here (e.g., fetching new data)
    await Future.delayed(const Duration(seconds: 2)); // Simulated delay
    setState(() {
      // Update the state to reflect the refreshed data, if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Enables pull-to-refresh
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
      ),
    );
  }
}
