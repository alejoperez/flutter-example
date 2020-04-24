import "package:flutter/material.dart";
import 'package:flutterexample/domain/transaction.dart';
import 'package:flutterexample/expenses/add_expense_view.dart';
import 'package:flutterexample/expenses/expenses_list_view.dart';
import 'package:flutterexample/expenses/weekly_expenses_chart.dart';
import 'dart:math';

class ExpensesScreen extends StatefulWidget {
  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  bool _showChart = false;
  final List<Transaction> _transactionList = [];

  List<Transaction> get _recentWeeklyTransactions => _transactionList
      .where((t) => t.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
      .toList();

  void _showAddTransactionBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx, builder: (_) => AddExpenseView(_addNewTransaction));
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    setState(() {
      _transactionList.add(Transaction(
          id: Random().nextInt(5000).toString(),
          title: title,
          amount: amount,
          date: selectedDate)
      );
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactionList.removeWhere((t) => t.id == id);
    });
  }



  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(title: Text("Expenses Manager"), actions: [
      IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () => _showAddTransactionBottomSheet(context))
    ]);

    double bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBar.preferredSize.height;

    return Scaffold(
        appBar: appBar,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Chart"),
                Switch(value: _showChart, onChanged: (value) {
                  setState(() {
                    _showChart = value;
                  });
                })
              ],
            ),
            _showChart ? Container(
                child: WeeklyExpensesChart(_recentWeeklyTransactions),
                height: bodyHeight * 0.7
            ) :
            Container(
              child: ExpensesListView(
                transactionList: _transactionList,
                deleteTransactionFunction: _deleteTransaction,
              ),
                height: bodyHeight * 0.7
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _showAddTransactionBottomSheet(context)
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
