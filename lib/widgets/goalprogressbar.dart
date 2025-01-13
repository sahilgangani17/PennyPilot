import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// TODO: Logic + backend yet to learn fast --for Sankalp Dawada

class GoalProgressBar extends StatefulWidget { // Make stateful
  final QueryDocumentSnapshot goalDoc; // Add goalDoc as property

  final String goalName;
  final double targetAmount;
  final double currentAmount;
  final double progress;


  const GoalProgressBar({
    super.key,
    required this.goalDoc,  // Pass in goalDoc
    required this.goalName,
    required this.targetAmount,
    required this.currentAmount,
    required this.progress,
  });



  @override
  State<GoalProgressBar> createState() => _GoalProgressBarState();
}




class _GoalProgressBarState extends State<GoalProgressBar> {

  @override
  Widget build(BuildContext context) {
    Color progressColor = Colors.green; // Default color


     if (widget.progress < 0.5) {
       progressColor = Colors.orange;
     }
    else if (widget.progress >= 0.75) {
      progressColor = Colors.blue;
    }



    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
                color: const Color.fromARGB(100, 200, 213, 185),
                borderRadius: BorderRadius.circular(20),
              ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.goalName,  // Access property with widget.
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${widget.targetAmount}', // Access property with widget.
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 10,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                ),

                child: Slider(
                    activeColor: progressColor, 
                    thumbColor: progressColor,   
                    inactiveColor: const Color(0xFFE0E0E0),
                    min: 0.0,
                    max: 1.0,
                    value: widget.progress.clamp(0.0, 1.0), 
                    onChanged: (newValue) async {
                    double updatedAmount = newValue * widget.targetAmount;

                    try {
                      await FirebaseFirestore.instance
                          .collection('goals')
                          .doc(widget.goalDoc.id) // Access document ID here
                          .update({'currentAmount': updatedAmount});
                    } catch (e) {
                      print('Error updating goal amount: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Failed to update goal amount')),
                      );
                    }
                  },
              )
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${widget.currentAmount} Saved',   // Access property with widget.
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  '${(widget.progress * 100).toInt()}%',  // Access property with widget.
                  style: TextStyle(
                    color: progressColor, 
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
