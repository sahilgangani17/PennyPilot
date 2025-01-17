import 'package:flutter/material.dart';
import 'package:penny_pilot/database/db_saving.dart';  // Database service
import 'package:penny_pilot/widgets/add_goal.dart'; // Add Goal dialog
import 'package:penny_pilot/widgets/goal_tile.dart'; // Goal Tile widget

class SavingGoals extends StatefulWidget {
  const SavingGoals({super.key});

  @override
  State<SavingGoals> createState() => _SavingGoalsState();
}

class _SavingGoalsState extends State<SavingGoals> {
  late Future<List<Map<String, dynamic>>> _goals; // Active goals
  late Future<double> _totalSavings; // Total savings

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    _goals = DatabaseService.instance.fetchAllGoals(); // Fetch active goals
    _totalSavings = DatabaseService.instance.fetchTotalSavings(); // Fetch total savings
  }

  void _refreshGoals() {
    setState(() {
      _fetchData(); // Re-fetch data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Total Savings Section
            FutureBuilder<double>(
              future: _totalSavings,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching total savings.'));
                }
                final totalSavings = snapshot.data ?? 0.0;
                return Container(
                  padding: const EdgeInsets.all(20),
                  //color: Colors.blue[800],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Total Savings',
                        style: TextStyle(
                          //color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '₹${totalSavings.toStringAsFixed(2)}',
                        style: const TextStyle(
                          //color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Active Goals Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Active Goals',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: AddGoal(),
                              ),
                            ).then((value) {
                              if (value == true) {
                                _refreshGoals(); // Refresh goals if a new one is added
                              }
                            });
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Goal'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Active Goals List
                    FutureBuilder<List<Map<String, dynamic>>>( // Ensure only active goals are fetched
                      future: _goals,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Error fetching active goals.'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No active goals.'));
                        }

                        final goals = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: goals.length,
                          itemBuilder: (context, index) {
                            final goal = goals[index];
                            return GoalTile(
                              progressColor: Colors.blue,
                              goalId: goal['id'],
                              goal: goal['title'],
                              savedAmount: goal['saved_amount'],
                              targetAmount: goal['target_amount'],
                              isCompleted: goal['isCompleted'] == 1,
                              onProgressUpdated: _refreshGoals,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
