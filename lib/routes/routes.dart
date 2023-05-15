import 'package:flutter/material.dart';
import 'package:inventory_app/models/models.dart';
import 'package:inventory_app/pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'loading': (_) => const LoadingPage(),
  'select_login_page': (_) => const SelectLoginPage(),
  'welcome': (_) => const LoginPage(),
  'home': (_) => const HomePage(),
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

  /* Products */
  'list_products_page': (_) => const ListProductsPage(),
  'add_product': (_) => const AddProduct(),
  'add_categories_page': (_) => const AddCategoryPage(),
  /* Sells */
  'sell_products': (_) => const SellProductsPage(),
  'sell_history': (_) => const SellHistory(),
  'sell_detail': (BuildContext context) => SellDetail(
        args: ModalRoute.of(context)?.settings.arguments as OrdersModel,
      ),
};
