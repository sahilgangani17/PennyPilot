  import 'package:flutter/material.dart';
  import 'package:penny_pilot/widgets/HeroCard_dashboard.dart';
  import 'package:penny_pilot/widgets/TraansactionCard_dashboard.dart';

  class Dashboard extends StatelessWidget {
    const Dashboard({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 64,
          title: Text(
            'Dashboard',
            style: TextStyle(color: Colors.black, fontSize: 32),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: SingleChildScrollView(
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
      );
    }
  }
