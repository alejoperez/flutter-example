import "package:flutter/material.dart";
import 'package:flutterexample/meals/screens/meals_by_category_screen.dart';
import 'package:flutterexample/meals/screens/meals_categories_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "/": (_) => MealsCategoriesScreen(),
          MealsByCategoryScreen.ROUTE_NAME: (_) => MealsByCategoryScreen()
        },
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.orange,
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: "Raleway",
            textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                title: TextStyle(
                    fontSize: 20,
                    fontFamily: "RobotoCondensed",
                    fontWeight: FontWeight.bold))));
  }
}
