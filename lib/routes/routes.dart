import 'package:flutter/material.dart';
import 'package:inventory_app/pages/pages.dart';
import 'package:inventory_app/widgets/widgets.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => const HomePage(),
  'welcome': (_) => const WelcomePage(),
  'login': (_) => const LoginPage(),

  /* Items */
  'item_detail': (_) => const ItemDetailPage(),
  'list_items_category': (_) => const ListCategoryItems(),

  /* Client */
  'clients': (_) => const ClientsPage(),
  'client_profile': (_) => const ClientProfilePage(),
  'client_register_page': (_) => const ClientRegisterPage(),
};
