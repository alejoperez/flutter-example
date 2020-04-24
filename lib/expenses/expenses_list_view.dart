import 'package:flutter/material.dart';
import 'package:flutterexample/domain/transaction.dart';
import 'package:intl/intl.dart';

class ExpensesListView extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function deleteTransactionFunction;

  ExpensesListView(
      {@required this.transactionList,
      @required this.deleteTransactionFunction});

  @override
  Widget build(BuildContext context) => Container(
      child: transactionList.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) => Container(
                  height: constraints.maxHeight * 0.7,
                  child: Image.asset("assets/images/empty_list.png",
                      fit: BoxFit.contain)))
          : ListView.builder(
              itemCount: transactionList.length,
              itemBuilder: (context, index) => Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColorLight,
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: FittedBox(
                                child: Text(NumberFormat.currency(
                                        symbol: "\$", decimalDigits: 0)
                                    .format(transactionList[index].amount))),
                          )),
                      title: Text(transactionList[index].title,
                          style: Theme.of(context).textTheme.title),
                      subtitle: Text(
                          DateFormat.yMMMMd()
                              .format(transactionList[index].date),
                          style: Theme.of(context).textTheme.body1),
                      trailing: IconButton(
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).errorColor),
                          onPressed: () => deleteTransactionFunction(
                              transactionList[index].id)),
                    ),
                  )));
}
