import "package:flutter/material.dart";
import 'package:flutterexample/expenses/expenses_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      home: ExpensesScreen(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amberAccent,
          fontFamily: "OpenSans",
        textTheme: ThemeData.light().textTheme.copyWith(
          button: TextStyle(color: Colors.white)
        )
      )
  );
}
