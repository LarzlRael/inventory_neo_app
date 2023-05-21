import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../pages/pages.dart';

final appRouter = GoRouter(
  initialLocation: '/loading',
  /* refreshListenable: goRouterNotifier, */
  routes: [
    ///* Primera pantalla
    GoRoute(
      path: '/',
      builder: (context, state) => const LoadingPage(),
    ),
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingPage(),
    ),
    GoRoute(
      path: '/welcome_page',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/login_page',
      builder: (context, state) => const LoginPage(),
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
        path: '/list_category_items',
        builder: (context, state) {
          int categoryId = state.extra as int;
          return ListCategoryItems(
            categoryId: categoryId,
          );
        }),
    /* clients */
    GoRoute(
      path: '/clients',
      builder: (context, state) => const ClientsPage(),
    ),
    GoRoute(
      path: '/client_profile',
      builder: (context, state) {
        ClientModel clientModel = state.extra as ClientModel;
        return ClientProfilePage(
          clientModel: clientModel,
        );
      },
    ),
    GoRoute(
      path: '/client_register_page',
      builder: (context, state) {
        ClientModel? clientModel = state.extra as ClientModel?;
        return ClientRegisterPage(
          clientModel: clientModel,
        );
      },
    ),

    GoRoute(
      path: '/materials_page',
      builder: (context, state) => const MaterialsPage(),
    ),
    GoRoute(
      path: '/categories_page',
      builder: (context, state) => const CategoriesPage(),
    ),
    /* Products Routes */
    GoRoute(
      path: '/sell_products',
      builder: (context, state) => const SellProductsPage(),
    ),
    GoRoute(
      path: '/add_product',
      builder: (context, state) {
        int? idProduct = state.extra as int?;
        return AddOrEditProduct(
          idProduct: idProduct,
        );
      },
    ),
    GoRoute(
      path: '/add_categories_page',
      builder: (context, state) {
        CategoryForm? categoryForm = state.extra as CategoryForm?;
        return AddCategoryPage(
          categoryForm: categoryForm,
        );
      },
    ),
    /* Sell routes */
    GoRoute(
      path: '/sell_history',
      builder: (context, state) => const SellHistory(),
    ),
    GoRoute(
      path: '/list_products_page',
      builder: (context, state) => const ListProductsPage(),
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
