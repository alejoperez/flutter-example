import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutterexample/domain/transaction.dart';

class ExpenseItemView extends StatelessWidget {
  const ExpenseItemView(
      {@required this.transaction, @required this.deleteTransactionFunction});

  final Transaction transaction;
  final Function deleteTransactionFunction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColorLight,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                  child: Text(
                      NumberFormat.currency(symbol: "\$", decimalDigits: 0)
                          .format(transaction.amount))),
            )),
        title:
            Text(transaction.title, style: Theme.of(context).textTheme.title),
        subtitle: Text(DateFormat.yMMMMd().format(transaction.date),
            style: Theme.of(context).textTheme.body1),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () => deleteTransactionFunction(transaction.id),
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                textColor: Theme.of(context).errorColor,
                label: const Text("Delete"))
            : IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                onPressed: () => deleteTransactionFunction(transaction.id)),
      ),
    );
  }
}
