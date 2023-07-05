import 'package:go_router/go_router.dart';
import 'package:inventory_app/widgets/widgets.dart';

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
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
        path: '/item_detail',
        builder: (context, state) {
          ProductModel sample = state.extra as ProductModel;
          return ItemDetailPage(productModel: sample);
        }),
    GoRoute(
        path: '/list_category_items',
        pageBuilder: (context, state) {
          CategoryTitle categoryTitle = state.extra as CategoryTitle;
          return fadeInTransition(
            child: ListCategoryItems(
              categoryTitle: categoryTitle,
            ),
          );
        }),
    /* clients */
    GoRoute(
      path: '/clients_page',
      pageBuilder: (context, state) => fadeInTransition(
        child: const ClientsPage(),
      ),
    ),
    GoRoute(
      path: '/client_profile',
      builder: (context, state) {
        int idClient = state.extra as int;
        return ClientProfilePage(
          idClient: idClient,
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
      pageBuilder: (context, state) => fadeInTransition(
        child: const SellProductsPage(),
      ),
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
          categoryFormParams: categoryForm,
        );
      },
    ),
    /* Sell routes */
    GoRoute(
      path: '/sell_history',
      pageBuilder: (context, state) => fadeInTransition(
        child: const SellHistory(),
      ),
    ),
    GoRoute(
      path: '/list_products_page',
      pageBuilder: (context, state) => fadeInTransition(
        child: const ListProductsPage(),
      ),
    ),
    GoRoute(
      path: '/material_add_edit_page',
      builder: (context, state) {
        TagModel? tagModel = state.extra as TagModel?;
        return MaterialAddEditPage(
          materialTag: tagModel,
        );
      },
    ),
    GoRoute(
      path: '/sell_detail',
      builder: (context, state) {
        OrderModel sample = state.extra as OrderModel;
        return SellDetail(
          args: sample,
        );
      },
    ),
  ],
);
