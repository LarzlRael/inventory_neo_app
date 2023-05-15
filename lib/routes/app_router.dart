import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../pages/pages.dart';

final appRouter = GoRouter(
  initialLocation: '/loading',
  /* refreshListenable: goRouterNotifier, */
  routes: [
    ///* Primera pantalla
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingPage(),
    ),
    GoRoute(
      path: '/select_login_page',
      builder: (context, state) => const SelectLoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
        path: '/item_detail',
        builder: (context, state) {
          ProductsModel sample = state.extra as ProductsModel;
          return ItemDetailPage(
            productModel: sample,
          );
        }),
    GoRoute(
        path: '/list_items_category',
        builder: (context, state) => const ListCategoryItems()),
    GoRoute(
      path: '/clients',
      builder: (context, state) => const ClientsPage(),
    ),
    GoRoute(
      path: '/client_profile',
      builder: (context, state) => const ClientProfilePage(),
    ),
    GoRoute(
      path: '/materials_page',
      builder: (context, state) => const MaterialsPage(),
    ),
    GoRoute(
      path: '/categories_page',
      builder: (context, state) => const CategoriesPage(),
    ),
    GoRoute(
      path: '/sell_products',
      builder: (context, state) => const SellProductsPage(),
    ),
    GoRoute(
      path: '/sell_history',
      builder: (context, state) => const SellHistory(),
    ),
    GoRoute(
      path: '/sell_detail',
      builder: (context, state) {
        OrdersModel sample = state.extra as OrdersModel;
        return SellDetail(
          args: sample,
        );
      },
    ),
  ],
);
