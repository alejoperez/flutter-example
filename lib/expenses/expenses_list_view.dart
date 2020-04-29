import 'package:flutter/material.dart';
import 'package:flutterexample/domain/transaction.dart';
import 'package:flutterexample/expenses/expense_item_view.dart';

class ExpensesListView extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function deleteTransactionFunction;

  const ExpensesListView(
      {@required this.transactionList,
      @required this.deleteTransactionFunction});

  @override
  Widget build(BuildContext context) => Container(
      child: transactionList.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) => Container(
                  height: constraints.maxHeight,
                  child: Image.asset("assets/images/empty_list.png",
                      fit: BoxFit.contain)))
          : ListView.builder(
              itemCount: transactionList.length,
              itemBuilder: (context, index) => ExpenseItemView(
                  transaction: transactionList[index],
                  deleteTransactionFunction: deleteTransactionFunction)));
}
