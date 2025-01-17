import 'package:flutter/material.dart';
import 'package:penny_pilot/models/goal.dart';
import 'package:penny_pilot/utils/icon_list.dart';

class CompletedGoalTile extends StatefulWidget {
  CompletedGoalTile({
    super.key,
    this.goal,
  });
  
  var appicons = AppIcons();
  final Goal? goal;

  @override
  State<CompletedGoalTile> createState() => _CompletedGoalTile();
  
}

class _CompletedGoalTile extends State<CompletedGoalTile> {
  
  Goal? goal;
  Color? color;

  @override
  void initState() {
    super.initState();
    goal = widget.goal!;
    color = Colors.amber;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
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
        ),
        child: ListTile(
          minVerticalPadding: 10,
          contentPadding: EdgeInsets.all(10),
          leading: SizedBox(
            width: 70,
            height: 100,
            child: Container(
              width: 30, 
              height: 30 ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: color!.withOpacity(0.2)
              ), 
              child: Center(
                child: Icon(Icons.savings_rounded),
                ),
              ), 
            ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(goal!.title)),
              Row(
                children: [
                  Icon(Icons.currency_rupee_sharp, color: color, size: 17),
                  Text( 
                    '${goal!.target_amount}',
                    style: TextStyle(color: color, fontSize: 17),
                  )
                ]
              ),
            ],
          ),
        ),    
      ),    
    );    
  }   

}