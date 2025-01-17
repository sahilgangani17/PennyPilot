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
        txnType = 'Expenses'; // Ensure this is a valid option in the dropdown
        txnCategory = 'Others'; // Ensure this is a valid option for category
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
      // key: _formKey,
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

              // Type Dropdown
              DropdownButtonFormField<String>(
                value: txnType.isEmpty ? null : txnType,  // Ensure txnType is not empty
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
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      txnType = value;
                      txnCategory = 'Others'; // Reset category to "Others" when type changes
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Amount Input
              TextFormField(
                controller: txnAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(AppIcons().getCurrencyIcon('Rupee')),
                  labelText: 'Amount',
                  border: const OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: appvalidate.validateAmount,
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
                controller: txnDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Add Transaction Button
              ElevatedButton(
                onPressed: () async {
                  if (txnAmountController.text.isNotEmpty ) {
                    Navigator.pop(context);
                    DateTime today = DateTime.now();
                    double txnAmount = convertStringToDouble(txnAmountController.text);
                    Txn? newTxn = (txnAmount > 0)
                      ? Txn(
                          id: txnId,
                          type: txnType,
                          amount: txnAmount,
                          category: txnCategory,
                          description: txnDescriptionController.text.isNotEmpty ? txnDescriptionController.text : 'Not Specified',
                          date: "${today.day} / ${today.month} / ${today.year}",
                        )
                      : null ;
                    if (widget.txn == null) {
                      await DatabaseService.instance.saveNewTxn(newTxn!);
                    }
                    else {
                      await DatabaseService.instance.updateTxn(newTxn!);
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
    if (txnType == null || txnType!.isEmpty) {
      return Container();  // Do not display dropdown if txnType is null or empty
    }

    return DropdownButtonFormField<String>(
      value: catType!.isEmpty ? null : catType,  // Ensure txnCategory is valid
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
              Icon(e['icon'] as IconData),
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
