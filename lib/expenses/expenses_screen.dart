import 'dart:math';
import 'dart:io';

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

import 'package:flutterexample/domain/transaction.dart';
import 'package:flutterexample/expenses/add_expense_view.dart';
import 'package:flutterexample/expenses/expenses_list_view.dart';
import 'package:flutterexample/expenses/weekly_expenses_chart.dart';

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
          date: selectedDate));
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactionList.removeWhere((t) => t.id == id);
    });
  }

  bool _isLandscape() =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  bool _isiOS() => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = _isiOS()
        ? CupertinoNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            middle: const Text("Expenses Manager", style: TextStyle(color: Colors.white)),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                child: const Icon(CupertinoIcons.add, color: Colors.white),
                onTap: () => _showAddTransactionBottomSheet(context),
              )
            ]),
          )
        : AppBar(title: const Text("Expenses Manager"), actions: [
            IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () => _showAddTransactionBottomSheet(context))
          ]);

    final double bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;

    var weeklyExpensesChartRatio;
    var expensesListViewRatio;

    if (_isLandscape()) {
      weeklyExpensesChartRatio = 0.6;
      expensesListViewRatio = 0.8;
    } else {
      weeklyExpensesChartRatio = 0.3;
      expensesListViewRatio = 0.7;
    }

    final weeklyExpensesChartView = Container(
        child: WeeklyExpensesChart(_recentWeeklyTransactions),
        height: bodyHeight * weeklyExpensesChartRatio);

    final expensesListView = Container(
        child: ExpensesListView(
          transactionList: _transactionList,
          deleteTransactionFunction: _deleteTransaction,
        ),
        height: bodyHeight * expensesListViewRatio);

    final switchLandscapeModeView = Container(
        height: bodyHeight * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Show Chart", style: Theme.of(context).textTheme.subtitle),
            _isiOS() ? CupertinoSwitch(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
                onChanged: (value) {
                  setState(() {
                    _showChart = value;
                  });
                }
            ) : Switch(
                activeColor: Theme.of(context).accentColor,
                value: _showChart,
                onChanged: (value) {
                  setState(() {
                    _showChart = value;
                  });
                })
          ],
        ));

    List<Widget> bodyList;
    if (_isLandscape()) {
      bodyList = [
        switchLandscapeModeView,
        _showChart ? weeklyExpensesChartView : expensesListView
      ];
    } else {
      bodyList = [weeklyExpensesChartView, expensesListView];
    }

    final bodyContent = SafeArea(
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: bodyList)));

    return _isiOS()
        ? CupertinoPageScaffold(navigationBar: appBar, child: bodyContent)
        : Scaffold(
            appBar: appBar,
            body: bodyContent,
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => _showAddTransactionBottomSheet(context)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
