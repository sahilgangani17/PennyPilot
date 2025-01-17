import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:penny_pilot/helper/helper_funcs.dart';
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
  int page = 1;
  Future<List<Txn>> _getData() async {
    switch(widget.displayTxnType!) {
      case TxnStates.allTxn: 
        return await DatabaseTxn.instance.getAllTxns(getCurrentUserEmail()!);
      case TxnStates.recentTxns:
        page = 0;
        return await DatabaseTxn.instance.get5RecentTxns(getCurrentUserEmail()!);
      case TxnStates.expensesTxns: 
        return await DatabaseTxn.instance.getExpensesTxns(getCurrentUserEmail()!);
      case TxnStates.incomeTxns:
        return await DatabaseTxn.instance.getIncomeTxns(getCurrentUserEmail()!);
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
                return TransactionTile(page: page, txn: txn);
              }).toList(),
            );
      }
    );
  }
}
