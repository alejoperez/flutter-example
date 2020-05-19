import "package:flutter/material.dart";
import 'package:flutterexample/app/chat_app.dart';
import 'package:flutterexample/app/expenses_app.dart';
import 'package:flutterexample/app/places_app.dart';
import 'package:flutterexample/app/shop_app.dart';
import 'package:flutterexample/expenses/expenses_screen.dart';
import 'app/meals_app.dart';
import 'package:flutter/services.dart';

void main() {
  /* Block app orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp
      ]
  );*/

// Expenses App
//  runApp(ExpensesApp());

//  Meals Application
//  runApp(MealsApp());

// Shop Application
//  runApp(ShopApp());

  // Places Application
//  runApp(PlacesApp());

// Chat Application
  runApp(ChatApp());
}
