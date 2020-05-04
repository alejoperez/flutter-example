import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterexample/domain/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const ROUTE_NAME = "/meal-detail";
  final Function _toggleFavoriteFunction;
  final Function _isMealFavoriteFunction;


  MealDetailScreen(this._toggleFavoriteFunction,this._isMealFavoriteFunction);

  Container _buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: Theme.of(context).textTheme.title),
    );
  }

  Widget _buildListContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        height: 200,
        width: 300,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 200,
                width: double.infinity,
                child: Image.network(meal.imageUrl, fit: BoxFit.cover)),
            _buildSectionTitle(context, "Ingredients"),
            _buildListContainer(ListView.builder(
              itemBuilder: (_, index) => Card(
                color: Theme.of(context).primaryColorLight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(meal.ingredients[index]),
                ),
              ),
              itemCount: meal.ingredients.length,
            )),
            _buildSectionTitle(context, "Steps"),
            _buildListContainer(ListView.builder(
                itemBuilder: (_, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).primaryColorLight,
                            child: Text("${index + 1}"),
                          ),
                          title: Text(meal.steps[index]),
                        ),
                        Divider()
                      ],
                    ),
                itemCount: meal.steps.length))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            _isMealFavoriteFunction(meal) ? Icons.star : Icons.star_border
        ),
        onPressed: () => _toggleFavoriteFunction(meal),
      ),
    );
  }
}
