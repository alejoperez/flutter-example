import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseChartBar extends StatelessWidget {
  final String weekDayLabel;
  final double totalDayExpenses;
  final double percentageOfTotalWeekExpenses;

  const ExpenseChartBar(
      {@required this.weekDayLabel,
      @required this.totalDayExpenses,
      @required this.percentageOfTotalWeekExpenses});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (ctx, constraints) => Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                  child: Text(NumberFormat.currency(symbol: "\$", decimalDigits: 0).format(totalDayExpenses))
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
                width: 10,
                height: constraints.maxHeight * 0.7,
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColorDark),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10))
                    ),
                    FractionallySizedBox(
                      heightFactor: percentageOfTotalWeekExpenses,
                      child: Container(
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColorLight.withOpacity(1))),
                    )
                  ],
                )),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(height: constraints.maxHeight * 0.1,child: FittedBox(child: Text(weekDayLabel)), alignment: Alignment.bottomCenter)
          ],
        )
    );
  }
}
