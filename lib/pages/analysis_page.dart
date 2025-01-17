import 'package:flutter/material.dart';
import 'package:penny_pilot/widgets/display_txns.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({
    super.key,
  });

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();

}

class _AnalysisPageState extends State<AnalysisPage> {
  
  var txnType = 'All';

  final Map<String,dynamic> _subpages = {
    'All': AllTxnPage(), //All
    'Expenses': ExpenseTxnPage(), //Expenses
    'Income': IncomeTxnPage(), //Income
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: DropdownButtonFormField<String>(
          value: txnType,
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
          items: [
            DropdownMenuItem(
              value: 'All',
              child: Text('All'),
            ),
            DropdownMenuItem(
              value: 'Expenses',
              child: Text('Expenses'),
            ),
            DropdownMenuItem(
              value: 'Income',
              child: Text('Income'),
            ),
            DropdownMenuItem(
              value: 'Savings',
              child: Text('Savings'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                txnType = value;
              });
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: _subpages[txnType]
      ),
      ),
    );
  }

  /* Widget _subpageButton(int i, String text, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = i;
          //print(_selectedIndex);
        });
      },
      child: Container(
        height: double.maxFinite,
        width: 130, 
        decoration: BoxDecoration(
          color: _selectedIndex == i ? Colors.white : Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              color: Colors.grey.withValues(alpha: 0.25),
              blurRadius: 10,
              spreadRadius: 4,
            )
          ]
        ),
        child: Center(
          child: Text(
            text, 
            style: TextStyle(
              color: color, 
              fontSize: 18
            )
          )
        ),
      )
    );
  } */
}

class AllTxnPage extends StatelessWidget {
  const AllTxnPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return DisplayTxns(displayTxnType: TxnStates.allTxn);
  }
}
class ExpenseTxnPage extends StatelessWidget {
  const ExpenseTxnPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return DisplayTxns(displayTxnType: TxnStates.expensesTxns);
  }
}
class IncomeTxnPage extends StatelessWidget {
  const IncomeTxnPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return DisplayTxns(displayTxnType: TxnStates.incomeTxns);
  }
}

class SavingTxtPage extends StatelessWidget {
  const SavingTxtPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return DisplayTxns(displayTxnType: TxnStates.savingTxns);
  }
}