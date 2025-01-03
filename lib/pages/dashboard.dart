import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        color: Colors.blue[50],
        child: HeroCard(),
      ),
    );
  }
}

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 10, left: 5, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:  Radius.circular(30), topRight: Radius.circular(30)),
                  color: Colors.white,
          
                ),
                child: Row(
                  children: [
                    CardOne(color: Colors.green ),
                    SizedBox(
                      width: 8,
                    ),
                    CardOne(color: Colors.red)
                ]),
              
              ),
            
            
            ],
          ),
        ),
      ],
    );
  }
}

class CardOne extends StatelessWidget {
  const CardOne({
    super.key, required this.color,
  });
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),

        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Credit", 
                  style: TextStyle(color: color, fontSize: 14),
                  ),
                  Text("₹ 59000",
                  style: TextStyle(color: color, fontSize: 30)
                  )
                ],
              ),
              // Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_upward_outlined, 
                  color: color
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
