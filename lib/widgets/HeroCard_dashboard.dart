import 'package:flutter/material.dart';



class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
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
        Text(
          "₹ 526,000",
          style: TextStyle(
            fontSize: 44,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
    
        Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                CardOne(
                  color: Colors.green,
                  title: 'Income',
                  icon: Icons.arrow_upward
                ),
                SizedBox(width: 10),
                CardOne(
                  color: Colors.red, 
                  title: 'Expenses',
                  icon: Icons.arrow_downward
                )
            ]),
          )
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
  });
  final Color color;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),

        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, 
                    style: TextStyle(color: color, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.currency_rupee_sharp, 
                        color: color,
                        size: 20
                      ),
                      Text(
                        "59000",
                        style: TextStyle(color: color, fontSize: 20)
                      ),  
                    ],
                  )
                ],
              ),
              Icon(
                icon, 
                color: color,
                size: 45,
              )
            ],
          ),
        ),
      ),
    );
  }
}
