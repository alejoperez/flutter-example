import 'package:flutter/material.dart';
import 'package:flutterexample/meals/screens/filters_screen.dart';

class DrawerMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme
                .of(context)
                .primaryColor,
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text("Cooking up!",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.white)),
          ),
          SizedBox(height: 20),
          _buildListTile("Meals", Icons.restaurant,
                  () {
                Navigator.of(context).pushReplacementNamed("/");
              }),
          _buildListTile(
              "Filters",
              Icons.settings,
                  () {
                Navigator.of(context).pushReplacementNamed(MealsFiltersScreen.ROUTE_NAME);
              }),
        ],
      ),
    );
  }

  ListTile _buildListTile(String title, IconData iconData,
      Function onItemMenuClicked) {
    return ListTile(
      leading: Icon(iconData, size: 26),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: "RobotoCondensed",
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: onItemMenuClicked,
    );
  }
}
