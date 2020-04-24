import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AddExpenseView extends StatefulWidget {
  final Function addTransactionFunction;

  AddExpenseView(this.addTransactionFunction);

  @override
  _AddExpenseViewState createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _onSubmitted() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

    if (title.isNotEmpty && amount != null && amount > 0 && _selectedDate != null) {
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
        } );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                    decoration: InputDecoration(labelText: "Title"),
                    controller: _titleController,
                    onSubmitted: (_) => _onSubmitted()),
                TextField(
                  decoration: InputDecoration(labelText: "Amount"),
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
                      FlatButton(
                          child: Text("Select date",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold)),
                          onPressed: _displayDatePicker)
                    ])),
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    child: Text("Add Transaction"),
                    onPressed: () => _onSubmitted())
              ],
            )));
  }
}
