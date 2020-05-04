import 'package:flutter/material.dart';
import 'package:flutterexample/meals/widget/drawer_menu_view.dart';

class MealsFiltersScreen extends StatefulWidget {
  static const ROUTE_NAME = "/meals-filters";
  final Function _saveFilters;
  final Map<String, bool> _currentFilters;

  MealsFiltersScreen(this._saveFilters,this._currentFilters);

  @override
  _MealsFiltersScreenState createState() => _MealsFiltersScreenState();
}

class _MealsFiltersScreenState extends State<MealsFiltersScreen> {
  var _isGlutenFree = false;
  var _isLactoseFree = false;
  var _isVegan = false;
  var _isVegetarian = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget._currentFilters["gluten"];
    _isLactoseFree = widget._currentFilters["lactose"];
    _isVegan = widget._currentFilters["vegan"];
    _isVegetarian = widget._currentFilters["vegetarian"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Filters"),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  "gluten": _isGlutenFree,
                  "lactose": _isLactoseFree,
                  "vegan": _isVegan,
                  "vegetarian": _isVegetarian,
                };
                widget._saveFilters(selectedFilters);
              },
            )
          ],
        ),
        drawer: DrawerMenuView(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text("Adjust meal selection",
                  style: Theme.of(context).textTheme.title),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile("Gluten Free",
                      "Only include gluten-free meals.", _isGlutenFree,(newValue) {
                        setState(() {
                          _isGlutenFree = newValue;
                        });
                      }),
                  _buildSwitchListTile("Lactose Free",
                      "Only include lactose-free meals.", _isLactoseFree,(newValue) {
                        setState(() {
                          _isLactoseFree = newValue;
                        });
                      }),
                  _buildSwitchListTile(
                      "Vegan", "Only include vegan meals.", _isVegan,(newValue) {
                    setState(() {
                      _isVegan = newValue;
                    });
                  }),
                  _buildSwitchListTile("Vegetarian",
                      "Only include vegetarian meals.",  _isVegetarian,(newValue) {
                        setState(() {
                          _isVegetarian = newValue;
                        });
                      }),
                ],
              ),
            )
          ],
        ));
  }

  SwitchListTile _buildSwitchListTile(
      String title, String subtitle, bool currentValue, Function updateValueFunction) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subtitle),
      onChanged: updateValueFunction,
    );
  }
}
