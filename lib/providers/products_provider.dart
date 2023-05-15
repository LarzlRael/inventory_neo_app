part of 'providers.dart';

class ProductsProvider extends ChangeNotifier {
  ProductsState _state = ProductsState();

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
    _state.copyWith(
      products: productsModelFromJson(clientRequest!.body),
    );
    notifyListeners();
  }

  get getProducts => _state.products;

  deleteProductById(String id) {
    _state.copyWith(
      products: _state.products.where((element) => element.id != id).toList(),
    );
    notifyListeners();
  }
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
