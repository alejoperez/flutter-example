import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterexample/base/widgets/adaptive_flat_button.dart';
import 'package:intl/intl.dart';

class AddExpenseView extends StatefulWidget {
  final Function addTransactionFunction;

  const AddExpenseView(this.addTransactionFunction);

  @override
  _AddExpenseViewState createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  bool _isiOS() => Platform.isIOS;

  void _onSubmitted() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

    if (title.isNotEmpty &&
        amount != null &&
        amount > 0 &&
        _selectedDate != null) {
      widget.addTransactionFunction(title, amount, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _displayDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
          child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: mediaQuery.viewInsets.bottom + 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _isiOS()
                      ? CupertinoTextField(
                          placeholder: "Title",
                          controller: _titleController,
                          onSubmitted: (_) => _onSubmitted())
                      : TextField(
                          decoration: const InputDecoration(labelText: "Title"),
                          controller: _titleController,
                          onSubmitted: (_) => _onSubmitted()),
                  _isiOS()
                      ? CupertinoTextField(
                          placeholder: "Amount",
                          controller: _amountController,
                          onSubmitted: (_) => _onSubmitted(),
                          keyboardType: TextInputType.number,
                        )
                      : TextField(
                          decoration: const InputDecoration(labelText: "Amount"),
                          controller: _amountController,
                          onSubmitted: (_) => _onSubmitted(),
                          keyboardType: TextInputType.number,
                        ),
                  Container(
                      height: 70,
                      child: Row(children: [
                        Expanded(
                          child: Text(_selectedDate != null
                              ? DateFormat.yMMMMd().format(_selectedDate)
                              : "No Date selected!"),
                        ),
                        AdaptiveFlatButton(
                          text: "Select Date",
                          onPressedFunction: _displayDatePicker,
                        )
                      ])),
                  _isiOS()
                      ? Container(
                          alignment: Alignment.center,
                          child: CupertinoButton(
                              color: Theme.of(context).primaryColor,
                              child: Text("Add Transaction",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .button
                                          .color)),
                              onPressed: () => _onSubmitted()))
                      : RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).textTheme.button.color,
                          child: const Text("Add Transaction"),
                          onPressed: () => _onSubmitted())
                ],
              ))),
    );
  }
}
