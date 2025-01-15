import 'package:flutter/material.dart';
import 'package:penny_pilot/utils/icon_list.dart';
import 'package:penny_pilot/widgets/display_txns.dart';

// ignore: must_be_immutable
class TransactionCard extends StatelessWidget {
  TransactionCard({
    super.key,
  });

  var appicons = AppIcons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Transactions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          DisplayTxns(displayTxnType: TxnStates.recentTxns)
        ],
      ),
    );
  }
}

