import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  
  Future<List<Txn>> _getData() async {
    switch(widget.displayTxnType!) {
      case TxnStates.allTxn: 
        return await DatabaseService.instance.getAllTxns();
      case TxnStates.recentTxns:
        return await DatabaseService.instance.get5RecentTxns();
      case TxnStates.expensesTxns: 
        return await DatabaseService.instance.getExpensesTxns();
      case TxnStates.incomeTxns:
        return await DatabaseTxn.instance.getIncomeTxns();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(), 
      builder: (BuildContext context, AsyncSnapshot<List<Txn>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text('Loading...'));
        }
        return snapshot.data!.isEmpty
          ? Center(child: Text('No Transactions made yet'))
          : ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: snapshot.data!.map((txn) {
                return TransactionTile(txn: txn);
              }).toList(),
            );
      }
    );
  }
}
