import "package:flutter/material.dart";
import 'package:flutterexample/meals/screens/filters_screen.dart';
import 'package:flutterexample/meals/screens/meals_by_category_screen.dart';
import 'package:flutterexample/meals/screens/meal_detail_screen.dart';
import 'package:flutterexample/meals/screens/meals_home_screen.dart';
import 'package:flutterexample/domain/dummy_data.dart';
import 'package:flutterexample/domain/meal.dart';

class MealsApp extends StatefulWidget {
  @override
  _MealsAppState createState() => _MealsAppState();
}

class _MealsAppState extends State<MealsApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void _saveFiltersData(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;
      availableMeals = DUMMY_MEALS.where(
          (meal) {
            if(_filters["gluten"] && !meal.isGlutenFree) {
              return false;
            }
            if(_filters["lactose"] && !meal.isLactoseFree) {
              return false;
            }
            if(_filters["vegan"] && !meal.isVegan) {
              return false;
            }
            if(_filters["vegetarian"] && !meal.isVegetarian) {
              return false;
            }
            return true;
          }
      ).toList();
    });
  }

  void _toggleFavoriteMeal(Meal meal) {
    final int existingIndex = favoriteMeals.indexWhere((m) => m.id == meal.id);

    if(existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(meal);
      });
    }
  }

  bool _isMealFavorite(Meal meal) => favoriteMeals.any((m) => m.id == meal.id);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "/": (_) => MealsHomeScreen(favoriteMeals),
          MealsByCategoryScreen.ROUTE_NAME: (_) => MealsByCategoryScreen(availableMeals),
          MealDetailScreen.ROUTE_NAME: (_) => MealDetailScreen(_toggleFavoriteMeal,_isMealFavorite),
          MealsFiltersScreen.ROUTE_NAME: (_) =>
              MealsFiltersScreen(_saveFiltersData,_filters),
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
