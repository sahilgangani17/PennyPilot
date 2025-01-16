import 'package:flutter/material.dart';
import 'package:penny_pilot/database/db_service.dart';
import 'package:penny_pilot/utils/appvalidate.dart';
import 'package:penny_pilot/utils/icon_list.dart';
import 'package:penny_pilot/helper/helper_funcs.dart';
import 'package:penny_pilot/models/transaction.dart';

enum EditTxnStates {
  create,
  edit
}

class TransactionOptions extends StatefulWidget {
 
  const TransactionOptions({
    super.key,
    this.txn,
    this.editTxnState = EditTxnStates.create
  });

  final Txn? txn;
  final editTxnState; 

  @override
  State<TransactionOptions> createState() => _TransactionOptionsState();
}

class _TransactionOptionsState extends State<TransactionOptions> {
  
  var appvalidate = Appvalidate();

  var _heading;
  int? txnId;
  var txnType = '';
  var txnCategory = '';
  var txnAmountController = TextEditingController();
  var txnDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    switch(widget.editTxnState) {
      case EditTxnStates.create:
        _heading = 'Add New Transaction';
        txnId = null;
        txnType = 'Expenses';
        txnCategory = 'Others';
        txnAmountController = TextEditingController();
        txnDescriptionController = TextEditingController();
        break;
      case EditTxnStates.edit:
        _heading = 'Edit this Transaction';
        if (widget.txn != null) {
          txnId = widget.txn!.id;
          txnType = widget.txn!.type;
          txnCategory = widget.txn!.category;
          txnAmountController.text = widget.txn!.amount.toString();
          txnDescriptionController.text = widget.txn!.description;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Heading
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text(
                    _heading,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  )
                )
              ),
              
              /* // Title Input
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: appvalidate.isEmptyCheck,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16), */

              // Type Dropdown
              DropdownButtonFormField<String>(
                value: txnType,
                decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
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
                      child : Text('Savings'),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      txnType = value;
                      txnCategory = 'Others';
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Amount Input
              TextFormField(
                controller: txnAmountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.currency_rupee_sharp),
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: appvalidate.isEmptyCheck,
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              CategoryDropdown(
                txnType: txnType,
                catType: txnCategory,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      txnCategory = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              
              // Description Input
              TextFormField(
                controller: txnDescriptionController      ,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Add Transaction Button
              ElevatedButton(
                onPressed: () async {
                  if (txnAmountController.text.isNotEmpty) {
                    Navigator.pop(context);
                    DateTime today = DateTime.now();
                    Txn newTxn = Txn(
                      id: txnId,
                      type: txnType,
                      amount: convertStringToDouble(txnAmountController.text),
                      category: txnCategory,
                      description: txnDescriptionController.text.isNotEmpty ? txnDescriptionController.text : 'Not Specified',
                      date: "${today.day} / ${today.month} / ${today.year}",
                    );
                    if (widget.txn == null) {
                      await DatabaseService.instance.saveNewTxn(newTxn);
                    }
                    else {
                      await DatabaseService.instance.updateTxn(newTxn);
                    }
                    setState(() {
                      txnAmountController.clear();
                      txnDescriptionController.clear();
                      txnId = null;
                      txnType = '';
                      txnCategory = '';
                    });
                  }
                  
                },
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    txnAmountController.clear();
                      txnDescriptionController.clear();
                      txnId = null;
                      txnType = '';
                      txnCategory = '';
                  });
                },
                child: const Text(
                  'Discard',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({
    super.key,
    required this.catType,
    required this.txnType,
    required this.onChanged,
  });

  final String? catType, txnType;
  final ValueChanged<String?> onChanged;
  
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: catType,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: "Category",
        border: OutlineInputBorder(),
      ),
      items: AppIcons().getTxnType(txnType).map((e) {
        return DropdownMenuItem<String>(
          value: e['name'],
          child: Row(
            children: [
              Icon(e['icon'] as IconData), // Type casting for safety
              const SizedBox(width: 8),
              Text(e['name']),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
