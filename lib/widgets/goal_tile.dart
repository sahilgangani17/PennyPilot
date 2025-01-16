import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:penny_pilot/utils/icon_list.dart';

class GoalTile extends StatefulWidget {
  GoalTile({
    super.key,
    required this.goal,
    required this.progressColor,
  });
  
  final String goal;
  final Color progressColor;


  @override
  State<GoalTile> createState() => _GoalTile();
  
}

class _GoalTile extends State<GoalTile> {
  /* Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              color: Colors.grey.withOpacity(0.09),
              blurRadius: 10,
              spreadRadius: 4,
            ),
          ],
        ), */

  var appicons = AppIcons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(100, 200, 213, 185),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.goal,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      appicons.getCurrencyIcon('Rupee'),
                      size: 15,
                    ),
                    Text(
                      '10,000',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ]
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: LinearProgressIndicator(
                value: 0.4,
                color: widget.progressColor,
                backgroundColor: widget.progressColor.withAlpha(25),
                minHeight: 6,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      appicons.getCurrencyIcon('Rupee'),
                      color: Colors.grey[600],
                      size: 15,
                    ),
                    Text(
                      '20,000 Saved',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                        //fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                Text(
                  '40%',
                  style: TextStyle(
                    color: widget.progressColor,
                  ),
                ),
              ]
            ),    
          ]
      ),    
    )
    );    
  }   

}