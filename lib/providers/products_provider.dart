part of 'providers.dart';

class ProductsProvider extends ChangeNotifier {
  ProductsState productsState = ProductsState();
  CategoriesState categoriesState = CategoriesState();

  /* createOrUpdateProduct(Map<String, dynamic> productLike) {
    final isProductIsList =
        _products.any((element) => element.id == product.id);
    final isProductIsList =
        _products.any((element) => element.id == product.id);

    if (!isProductIsList) {
      _products = _products.copyWith(products: [...state.products, product]);
      return true;
    }

    _state.copyWith(
        products: _state.products
            .map((element) => element.id == product.id ? product : element)
            /* products: _state.products.map((element) => element.id == product.id ? product : element) */

            .toList());
    return true;
  } */

  fetchProductsAllProducts() async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products',
      {},
      'xd',
    );
    productsState.copyWith(
      products: productsModelFromJson(clientRequest!.body),
    );
    notifyListeners();
  }

  get getProducts => productsState.products;

  deleteProductById(String id) {
    productsState.copyWith(
      products:
          productsState.products.where((element) => element.id != id).toList(),
    );
    notifyListeners();
  }

  get getCategories => categoriesState.categories;
  fetchCategories() async {
    final res = await getAction('/products/categories');
    final orders = categoriesModelFromJson(res!.body);

    categoriesState.copyWith(
      categories: orders,
      isLoading: false,
    );
    notifyListeners();
  }
}

class CategoriesState {
  final bool isLoading;
  final List<CategoriesModel> categories;
  CategoriesState({
    this.isLoading = false,
    this.categories = const [],
  });
  CategoriesState copyWith({
    bool? isLoading,
    List<CategoriesModel>? categories,
  }) =>
      CategoriesState(
        isLoading: isLoading ?? this.isLoading,
        categories: categories ?? this.categories,
      );
}

class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<ProductsModel> products;

  ProductsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const [],
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<ProductsModel>? products,
  }) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
