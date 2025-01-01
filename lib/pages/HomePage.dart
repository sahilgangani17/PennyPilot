import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> category = [
    'Other',
    'Food and Dining',
    'Shopping',
    'Travelling',
    'Entertainment',
    'Medical',
    'Education',
    'Bills and Utilities',
    'Investments',
    'Rent',
    'Taxes',
    'Insurance',
    'Gifts and Donation'
  ];
 
  TextEditingController amountController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  
  void _openNewTransaction() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                icon: Icon(Icons.currency_rupee_sharp),
                hintText: '0',
                labelText: 'Amount'
              ),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                icon: Icon(Icons.more_horiz),
                hintText: 'Others',
                labelText: 'Category',
              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 32,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Analysis'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc,color: Colors.transparent),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More'
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _openNewTransaction,
        tooltip: 'Add Transaction',
        child: const Icon(Icons.add),
      ),
    );
  }
}