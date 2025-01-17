import 'package:flutter/material.dart';
import 'package:penny_pilot/database/db_saving.dart';
import 'package:penny_pilot/models/transaction.dart';
import 'package:penny_pilot/database/db_service.dart';
import 'package:penny_pilot/widgets/transaction_tile.dart';

enum TxnStates {
  allTxn,
  recentTxns,
  expensesTxns,
  incomeTxns,
  savingTxns
}

class DisplayTxns extends StatefulWidget {
  const DisplayTxns({super.key, required this.displayTxnType});

  final TxnStates? displayTxnType;

  @override
  State<DisplayTxns> createState() => _DisplayTxns();
}

class _DisplayTxns extends State<DisplayTxns> {

  // Fetch data based on the txn type
  Future<List<Txn>> _getData() async {
    switch(widget.displayTxnType!) {
      case TxnStates.allTxn: 
        return await DatabaseService.instance.getAllTxns();
      case TxnStates.recentTxns:
        return await DatabaseService.instance.get5RecentTxns();
      case TxnStates.expensesTxns: 
        return await DatabaseService.instance.getExpensesTxns();
      case TxnStates.incomeTxns:
        return await DatabaseService.instance.getIncomeTxns();
      case TxnStates.savingTxns:
        return await DatabaseSaving.instance.fetchGoalHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Txn>>(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<List<Txn>> snapshot) {
        // Show loading message while data is being fetched
        if (!snapshot.hasData) {
          return Center(child: Text('Loading...'));
        }

        // Check if no data is available
        if (snapshot.data!.isEmpty) {
          return Center(child: Text('No Transactions made yet'));
        }

        // If data exists, display the list of transactions
        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: snapshot.data!.map((txn) {
            return TransactionTile(txn: txn); // Display each transaction
          }).toList(),
        );
      },
    );
  }
}
