// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) return;
    widget.addTx(
      titleController.text,
      double.parse(amountController.text),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              // onChanged: (value) => titleInput = value,
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Enter desired title',
              ),
              keyboardType: TextInputType.datetime,
              onSubmitted: (val) => submitData(),
            ),
            TextField(
              // onChanged: (value) => amountInput = value,
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter desired amount',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (val) => submitData(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(
                    r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$'))
              ],
            ),
            TextButton(
              onPressed: submitData,
              child: Text('Add Transaction'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 169, 147, 173),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
