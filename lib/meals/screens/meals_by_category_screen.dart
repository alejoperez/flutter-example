import 'package:flutter/material.dart';
import 'package:flutterexample/domain/category.dart';
import 'package:flutterexample/domain/meal.dart';
import 'package:flutterexample/domain/dummy_data.dart';
import 'package:flutterexample/meals/widget/meal_item_view.dart';

class MealsByCategoryScreen extends StatelessWidget {
  static const ROUTE_NAME = "/meals-by-category";

  Map<String, Object> _args(BuildContext ctx) =>
      ModalRoute.of(ctx).settings.arguments as Map<String, Category>;

  Category _category(BuildContext context) => _args(context)["category"];

  List<Meal> _getMealsByCategory(Category category) => DUMMY_MEALS
      .where((meal) => meal.categories.contains(category.id))
      .toList();

  @override
  Widget build(BuildContext context) {
    final Category category = _category(context);
    final List<Meal> mealsByCategory = _getMealsByCategory(category);
    return Scaffold(
        appBar: AppBar(title: Text(category.title)),
        body: ListView.builder(
          itemBuilder: (_, index) => MealItemView(mealsByCategory[index]),
          itemCount: mealsByCategory.length,
        ));
  }
}
