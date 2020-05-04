import 'package:flutter/material.dart';
import 'package:flutterexample/meals/widget/category_item_view.dart';
import 'package:flutterexample/domain/dummy_data.dart';

class MealsCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(25),
        itemBuilder: (ctx, index) => CategoryItemView(DUMMY_CATEGORIES[index]),
        itemCount: DUMMY_CATEGORIES.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20));
  }
}
