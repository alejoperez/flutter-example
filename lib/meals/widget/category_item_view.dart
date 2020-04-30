import 'package:flutter/material.dart';
import 'package:flutterexample/domain/category.dart';

class CategoryItemView extends StatelessWidget {
  final Category category;

  const CategoryItemView(this.category);

  void _onCategoryClicked(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
        "/meals-by-category",
        arguments: { "category": category}
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => _onCategoryClicked(context),
        splashColor: Theme
            .of(context)
            .primaryColor,
        borderRadius: BorderRadius.circular(15),
        child: Container(
            padding: const EdgeInsets.all(15),
            child:
            Text(category.title, style: Theme
                .of(context)
                .textTheme
                .title),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [category.color.withOpacity(0.7), category.color],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(15))));
  }
}
