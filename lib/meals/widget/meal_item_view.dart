import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterexample/domain/meal.dart';

class MealItemView extends StatelessWidget {
  final Meal meal;

  MealItemView(this.meal);

  String get _complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return "Simple";
      case Complexity.Challenging:
        return "Challenging";
      case Complexity.Hard:
        return "Hard";
      default:
        return "";
    }
  }

  String get _affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return "Affordable";
      case Affordability.Luxurious:
        return "Luxurious";
      case Affordability.Pricey:
        return "Pricey";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Image.network(meal.imageUrl,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover)),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                        color: Colors.black54,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        width: 300,
                        child: Text(
                          meal.title,
                          style: TextStyle(fontSize: 26, color: Colors.white),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule),
                        SizedBox(width: 6),
                        Text("${meal.duration} min")
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.work),
                        SizedBox(width: 6),
                        Text(_complexityText)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money),
                        SizedBox(width: 6),
                        Text(_affordabilityText)
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
