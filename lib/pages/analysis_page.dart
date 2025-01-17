import 'package:flutter/material.dart';
import 'package:penny_pilot/widgets/txn_page_expenses.dart';
import 'package:penny_pilot/widgets/txn_page_income.dart';
import 'package:penny_pilot/widgets/txn_page_all.dart';
import 'package:penny_pilot/widgets/txn_page_savings.dart';

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
    'Savings': GoalTxnPage(),
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