import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:penny_pilot/database/db_service.dart';
import 'package:penny_pilot/widgets/PieChart.dart';
import 'package:penny_pilot/widgets/display_txns.dart';

class IncomeTxnPage extends StatefulWidget {
  const IncomeTxnPage({super.key});

  @override
  _IncomeTxnPageState createState() => _IncomeTxnPageState();
}

class _IncomeTxnPageState extends State<IncomeTxnPage> {
  late Future<Map<String, double>> pieChartData;

  @override
  void initState() {
    super.initState();
    pieChartData = fetchData(); // Initializing fetchData method
  }

  // Fetching the category-wise income from the database
  Future<Map<String, double>> fetchData() async {
    final dbService = DatabaseService.instance;
    var categoryData = await dbService.getCategoryWiseIncome(); // Adjust this to fetch income data
    return categoryData;
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
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available.')); // No data found
        } else {
          final data = snapshot.data!;
          // Dynamically generate colors based on the number of categories
          final colors = generateColors(data.length);

          return Column(
            children: [
              PieChartWidget(
                sections: createSections(data, colors),
              ),
              // Display legend with categories
              _buildLegend(data, colors),
              // Display the list of transactions (income)
              DisplayTxns(displayTxnType: TxnStates.incomeTxns), // Show the transaction list for income
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
      title: '', // Clear the title text
      color: colors[data.keys.toList().indexOf(entry.key)],
      radius: 60, // Increase radius for larger sections
      titleStyle: TextStyle(fontSize: 0, fontWeight: FontWeight.bold, color: Colors.transparent), // Hide the title text
      borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 2), // Add border for distinction
    );
  }).toList();
}



  // Helper function to dynamically generate colors for the pie chart
  List<Color> generateColors(int count) {
    List<Color> colors = [];
    for (int i = 0; i < count; i++) {
      // Generating random colors based on index
      colors.add(Colors.primaries[i % Colors.primaries.length]);
    }
    return colors;
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
                  '${data.keys.toList()[index]}: ${data.values.toList()[index].toStringAsFixed(1)}', // Category name and value
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
