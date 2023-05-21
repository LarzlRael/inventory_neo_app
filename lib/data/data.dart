import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_app/pages/pages.dart';
import 'package:inventory_app/widgets/buttons/buttons.dart';

final List<Widget> bottomItemsWithLogin = <Widget>[
  const Home(),
  const Register(),
  Inventory(),
  const Profile(),
];

List<Widget> registerOptions(BuildContext context) {
  return [
    CircleButton(
      color: Colors.blue,
      icon: Icons.home_work,
      text: 'Productos',
      onPressed: () {
        context.push('/list_products_page');
      },
    ),
    CircleButton(
      color: Colors.purple,
      icon: Icons.money,
      text: 'Categorias',
      onPressed: () {
        context.push('/categories_page');
      },
    ),
    CircleButton(
      color: Colors.green,
      icon: Icons.person_search,
      text: 'Materiales',
      onPressed: () {
        context.push('/materials_page');
      },
    ),
    CircleButton(
      color: Colors.brown,
      icon: Icons.person,
      text: 'Clientes',
      onPressed: () {
        context.push('/client_register_page');
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
  'Completado': 'completed',
  'Pendiente': 'pending',
  'Procesando': 'processing',
  'En espera': 'on-hold',
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
