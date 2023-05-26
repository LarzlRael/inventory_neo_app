import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_app/pages/pages.dart';
import 'package:inventory_app/widgets/buttons/buttons.dart';

final List<Widget> bottomItemsWithLogin = <Widget>[
  const Home(),
  const Register(),
  const Inventory(),
  const Profile(),
];

const menuAdminItems = [
  ManagementCards(
    cardTitle: 'Clientes',
    cardIcon: Icons.person,
    cardRoute: '/clients_page',
  ),
  ManagementCards(
    cardTitle: 'Productos',
    cardIcon: Icons.production_quantity_limits,
    cardRoute: '/list_products_page',
  ),
  ManagementCards(
    cardTitle: 'Ventas',
    cardIcon: Icons.sell,
    cardRoute: '/sell_products',
  ),
  ManagementCards(
    cardTitle: 'Historial',
    cardIcon: Icons.history,
    cardRoute: '/sell_history',
  ),
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
        context.push('/clients_page');
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
