import 'package:flutter/material.dart';
import 'package:inventory_app/models/models.dart';
import 'package:inventory_app/pages/pages.dart';
import 'package:inventory_app/widgets/widgets.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => const HomePage(),
  'welcome': (_) => const WelcomePage(),
  'login': (_) => const LoginPage(),

  /* Items */
  'item_detail': (BuildContext context) => ItemDetailPage(
        productModel:
            ModalRoute.of(context)?.settings.arguments as ProductsModel,
      ),
  'list_items_category': (_) => const ListCategoryItems(),

  /* Client */
  'clients': (_) => const ClientsPage(),
  'client_profile': (_) => const ClientProfilePage(),
  'client_register_page': (_) => const ClientRegisterPage(),
  'materials_page': (_) => const MaterialsPage(),
  'categories_page': (_) => const CategoriesPage(),
  /* Productos */
  'list_products_page': (_) => const ListProductsPage(),
  'add_product': (_) => const AddProduct(),
  'add_categories_page': (_) => const AddCategoryPage(),
};
