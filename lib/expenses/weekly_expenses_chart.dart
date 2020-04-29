import 'package:flutter/material.dart';
import 'package:flutterexample/domain/transaction.dart';
import 'package:flutterexample/expenses/expense_chart_bar.dart';
import 'package:intl/intl.dart';

class WeeklyExpensesChart extends StatelessWidget {
  final List<Transaction> _recentWeeklyTransactions;

  const WeeklyExpensesChart(this._recentWeeklyTransactions);

  List<Map<String, Object>> get _weeklyExpensesSummary =>
      List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        final totalDayExpenses = _recentWeeklyTransactions
            .where((t) =>
                t.date.day == weekDay.day &&
                t.date.month == weekDay.month &&
                t.date.year == weekDay.year)
            .fold<double>(
                0, (total, transaction) => total + transaction.amount);
        return {
          "day": DateFormat.E().format(weekDay),
          "amount": totalDayExpenses
        };
      }).reversed.toList();

  double get _totalWeeklyExpenses => _weeklyExpensesSummary.fold<double>(
      0, (total, day) => total + day["amount"]);

  double calculatePercentageFromTotalWeek(double amount) =>
      _totalWeeklyExpenses == 0 ? 0 : amount / _totalWeeklyExpenses;

  @override
  Widget build(BuildContext context) {
    print(_weeklyExpensesSummary);
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _weeklyExpensesSummary
                  .map((day) => Expanded(
                      child: ExpenseChartBar(
                          weekDayLabel: day["day"],
                          totalDayExpenses: day["amount"],
                          percentageOfTotalWeekExpenses:
                              calculatePercentageFromTotalWeek(day["amount"]))))
                  .toList()),
        ));
  }
}
