import 'package:flutter/material.dart';
import 'package:flutterexample/domain/category.dart';
import 'package:flutterexample/domain/meal.dart';
import 'package:flutterexample/meals/widget/meal_item_view.dart';

class MealsByCategoryScreen extends StatefulWidget {
  static const ROUTE_NAME = "/meals-by-category";
  final List<Meal> _availableMeals;

  MealsByCategoryScreen(this._availableMeals);

  @override
  _MealsByCategoryScreenState createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  Category category;
  List<Meal> mealsByCategory;
  var _isDataLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataLoaded) {
      category = ModalRoute.of(context).settings.arguments;
      mealsByCategory = widget._availableMeals
          .where((meal) => meal.categories.contains(category.id))
          .toList();
      _isDataLoaded = true;
    }
  }

  void _removeMeal(String mealId) {
    setState(() {
      mealsByCategory.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(category.title)),
        body: ListView.builder(
          itemBuilder: (_, index) {
            return MealItemView(mealsByCategory[index]);
          },
          itemCount: mealsByCategory.length,
        ));
  }
}
