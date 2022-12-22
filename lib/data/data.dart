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
    CircleButton(
      color: Colors.brown,
      icon: Icons.person_add,
      text: 'Agregar cliente',
      onPressed: () {
        Navigator.pushNamed(context, 'client_register_page');
      },
    ),
  ];
}

final statusList = {
  'completed': 'Completado',
  'pending': 'Pendiente',
  'on-hold': 'En espera',
  'cancelled': 'Cancelado',
  'processing': 'Procesando',
  'refunded': 'Reembolsado',
  'failed': 'Fallido',
};
final statusListTransalteEn = {
  'Pendiente': 'pending',
  'Procesando': 'processing',
  'En espera': 'on-hold',
  'Completado': 'completed',
  'Cancelado': 'cancelled',
  'Reembolsado': 'refunded',
  'Fallido': 'failed',
};
final statusListList = [
  'Completado',
  'En espera',
  'Pendiente',
  'Cancelado',
  'Procesando',
  'Reembolsado',
  'Fallido',
];
