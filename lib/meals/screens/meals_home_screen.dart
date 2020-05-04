import 'package:flutter/material.dart';
import 'package:flutterexample/meals/screens/favorite_meals_screen.dart';
import 'package:flutterexample/meals/screens/meals_categories_screen.dart';
import 'package:flutterexample/meals/widget/drawer_menu_view.dart';
import 'package:flutterexample/domain/meal.dart';

class MealsHomeScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;

  MealsHomeScreen(this._favoriteMeals);

  @override
  _MealsHomeScreenState createState() => _MealsHomeScreenState();
}

class _MealsHomeScreenState extends State<MealsHomeScreen> {
  List<Map<String, Object>> _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {"title": "Categories", "screen": MealsCategoriesScreen()},
      {
        "title": "Favorites",
        "screen": FavoriteMealsScreen(widget._favoriteMeals)
      }
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedIndex]["title"])),
      body: _pages[_selectedIndex]["screen"],
      drawer: DrawerMenuView(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            icon: Icon(Icons.category),
            title: Text("Categories"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            icon: Icon(Icons.favorite),
            title: Text("Favorites"),
          )
        ],
      ),
    );
  }
}
