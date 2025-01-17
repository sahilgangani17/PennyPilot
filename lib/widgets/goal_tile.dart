import 'package:flutter/material.dart';
import 'package:penny_pilot/database/db_saving.dart';

class GoalTile extends StatefulWidget {
  final String goal;
  final double savedAmount;
  final double targetAmount;
  final Color progressColor;
  final int goalId;
  final VoidCallback onProgressUpdated;
  final bool isCompleted;

  const GoalTile({
    super.key,
    required this.goal,
    required this.savedAmount,
    required this.targetAmount,
    required this.progressColor,
    required this.goalId,
    required this.onProgressUpdated,
    required this.isCompleted,
  });

  @override
  State<GoalTile> createState() => _GoalTileState();
}

class _GoalTileState extends State<GoalTile> {
  final TextEditingController _addAmountController = TextEditingController();

  void _addAmount() async {
    final addAmount = double.tryParse(_addAmountController.text);

    if (addAmount == null || addAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    final newSavedAmount = widget.savedAmount + addAmount;

    // Update goal progress in the database
    await DatabaseSaving.instance.updateGoalProgress(widget.goalId, newSavedAmount);

    // Update the progress bar
    setState(() {
      // Update progress (this triggers UI refresh)
    });

    // Check if the goal is completed after the update
    if (newSavedAmount >= widget.targetAmount) {
      // Mark as completed and move to history
      await DatabaseSaving.instance.markGoalAsCompleted(widget.goalId);
    }

    // Refresh parent UI to show updated goals
    widget.onProgressUpdated();

    // Clear the input field
    _addAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.savedAmount / widget.targetAmount;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.isCompleted
              ? const Color.fromARGB(100, 230, 230, 230) // Gray for completed goals
              : const Color.fromARGB(100, 200, 213, 185), // Green for active goals
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Goal Title and Current Saved Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.goal,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  '₹${widget.savedAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Progress Bar
            Padding(
              padding: EdgeInsets.all(16),
              child: LinearProgressIndicator(
                value: progress > 1 ? 1 : progress,
                color: widget.progressColor,
                backgroundColor: widget.progressColor.withAlpha(50),
                borderRadius: BorderRadius.circular(5),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 10),

            // Target Amount and Progress Percentage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Target: ₹${widget.targetAmount.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(1)}%',
                  style: TextStyle(color: widget.progressColor),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Add Amount Input and Button (Disable if completed)
            if (!widget.isCompleted)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _addAmountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Add Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addAmount,
                    child: const Text('Add'),
                  ),
                ],
              )
            else
              const Text(
                'Goal Completed',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
