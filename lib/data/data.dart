import 'package:flutter/material.dart';
import 'package:inventory_app/pages/pages.dart';
import 'package:inventory_app/widgets/buttons/buttons.dart';

final List<Widget> bottomItemsWithLogin = <Widget>[
  Home(),
  Register(),
  Inventory(),
  Profile(),
];

List<Widget> registerOptions(BuildContext context) {
  return [
    CircleButton(
      color: Colors.blue,
      icon: Icons.home_work,
      text: 'Agregar producto',
      onPressed: () {
        Navigator.pushNamed(context, 'list_products_page');
      },
    ),
    CircleButton(
      color: Colors.purple,
      icon: Icons.money,
      text: 'Agregar categoria',
      onPressed: () {
        Navigator.pushNamed(context, 'categories_page');
      },
    ),
    CircleButton(
      color: Colors.green,
      icon: Icons.person_search,
      text: 'Agregar material',
      onPressed: () {
        Navigator.pushNamed(context, 'materials_page');
      },
    ),
  ];
}
