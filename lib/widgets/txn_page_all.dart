import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:penny_pilot/database/db_saving.dart';
import 'package:penny_pilot/database/db_txns.dart';
import 'package:penny_pilot/helper/helper_funcs.dart';
import 'package:penny_pilot/widgets/PieChart.dart';
import 'package:penny_pilot/widgets/display_txns.dart';
import 'package:penny_pilot/widgets/txn_page_savings.dart';

class AllTxnPage extends StatefulWidget {
  const AllTxnPage({super.key});

  @override
  _AllTxnPageState createState() => _AllTxnPageState();
}

class _AllTxnPageState extends State<AllTxnPage> {
  late Future<Map<String, double>> pieChartData;

  // Fetch total income and expense from the database
  Future<Map<String, double>> fetchData() async {
    final dbService = DatabaseTxn.instance;

    double income = await dbService.getTotalIncome(getCurrentUserEmail()!);
    double expense = await dbService.getTotalExpense(getCurrentUserEmail()!);
    double saving = await DatabaseSaving.instance.fetchTotalSaved(getCurrentUserEmail()!);
    

    return {'Income': income, 'Expense': expense, 'Savings': saving}; // Returning a map
  }

  @override
  void initState() {
    super.initState();
    pieChartData = fetchData(); // Correctly initializing fetchData without arguments
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: pieChartData, // Using the pieChartData
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Loading state
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Error handling
        } else if (!snapshot.hasData || snapshot.data!.isEmpty || isDataEmpty(snapshot.data!) ) {
          return Center(child: Text('No data available.')); // No data found
        } else {
          final data = snapshot.data!;
          final colors = [Colors.green, Colors.red, Colors.amber]; // Pie chart colors

          return Column(
            children: [
              PieChartWidget(
                sections: createSections(data, colors),
              ),
              // Display legend with labels for Income and Expense
              _buildLegend(data, colors),
              DisplayTxns(displayTxnType: TxnStates.allTxn),
              GoalTxnPage(),
            ],
          );
        }
      },
    );
  }

  // Helper function to create PieChartSectionData from the data
 List<PieChartSectionData> createSections(Map<String, double> data, List<Color> colors) {
  // ignore: unused_local_variable
  double total = data.values.reduce((a, b) => a + b); // Get total for percentage calculation
  return data.entries.map((entry) {
    return PieChartSectionData(
      value: entry.value,
      // Remove title and text inside the section
      title: '', // No text inside the section
      color: colors[data.keys.toList().indexOf(entry.key)],
      radius: 60, // Increase radius for larger sections
      titleStyle: TextStyle(fontSize: 0, fontWeight: FontWeight.bold, color: Colors.transparent), // Hide the title text
      borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 2), // Add border for distinction
    );
  }).toList();
}


  // Helper function to build the legend for each section (outside the pie chart)
  Widget _buildLegend(Map<String, double> data, List<Color> colors) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(data.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: colors[index], // Legend color box
                ),
                SizedBox(width: 8),
                Text(
                  '${data.keys.toList()[index]}: ${data.values.toList()[index].toStringAsFixed(1)}', // Label with category name and value
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  bool isDataEmpty(Map<String, double> data) {
    return data.isEmpty || data.values.every((value) => value == 0);
  }
}
