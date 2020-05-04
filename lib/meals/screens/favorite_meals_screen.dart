import 'package:flutter/material.dart';
import 'package:flutterexample/domain/meal.dart';
import 'package:flutterexample/meals/widget/meal_item_view.dart';

class FavoriteMealsScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoriteMealsScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if(favoriteMeals.isEmpty) {
      return Center(child: Text("Yo have no favorite meals - start adding some!"));
    } else {
      return ListView.builder(
        itemBuilder: (_, index) {
          var meal = favoriteMeals[index];
          return MealItemView(meal);
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
