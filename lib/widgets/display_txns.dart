import 'package:flutter/material.dart';
import 'package:penny_pilot/models/transaction.dart';
import 'package:penny_pilot/database/db_txns.dart';
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

  // Fetch data based on the txn type
  Future<List<Txn>> _getData() async {
    switch(widget.displayTxnType!) {
      case TxnStates.allTxn: 
        return await DatabaseTxn.instance.getAllTxns();
      case TxnStates.recentTxns:
        return await DatabaseTxn.instance.get5RecentTxns();
      case TxnStates.expensesTxns: 
        return await DatabaseTxn.instance.getExpensesTxns();
      case TxnStates.incomeTxns:
        return await DatabaseTxn.instance.getIncomeTxns();
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
