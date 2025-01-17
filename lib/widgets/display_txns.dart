import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:penny_pilot/models/transaction.dart';
import 'package:penny_pilot/database/db_service.dart';
import 'package:penny_pilot/widgets/transaction_tile.dart';

enum TxnStates {
  allTxn,
  recentTxns,
  expensesTxns,
  incomeTxns,
}

class DisplayTxns extends StatefulWidget {
  const DisplayTxns({super.key, required this.displayTxnType});

  final TxnStates? displayTxnType;

  @override
  State<DisplayTxns> createState() => _DisplayTxns();
}

class _DisplayTxns extends State<DisplayTxns> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<List<Txn>> _getData() async {
    switch (widget.displayTxnType!) {
      case TxnStates.allTxn:
        return await DatabaseService.instance.getAllTxns();
      case TxnStates.recentTxns:
        return await DatabaseService.instance.get5RecentTxns();
      case TxnStates.expensesTxns:
        return await DatabaseService.instance.getExpensesTxns();
      case TxnStates.incomeTxns:
        return await DatabaseService.instance.getIncomeTxns();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Txn>>( // Explicitly specify the type of FutureBuilder
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<List<Txn>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Show a loading spinner
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Transactions made yet'));
        }

        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: snapshot.data!.map((txn) {
            return TransactionTile(
              txn: txn,
              flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin, // Pass the required plugin or handle null safely
            );
          }).toList(),
        );
      },
    );
  }
}
