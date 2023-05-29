part of 'providers.dart';

class ProductsProvider extends ChangeNotifier {
  late ProductProvider productProvider;

  void update(ProductProvider newProductProvider) {
    productProvider = newProductProvider;
  }

  ProductsState productsState = ProductsState();

  createOrUpdateProduct(
    Map<String, dynamic> productLike, {
    int? idProduct,
  }) async {
    final result = await productProvider.createOrUpdateProduct(productLike,
        idProduct: idProduct);

    if (idProduct == null) {
      productsState = productsState.copyWith(
        products: [
          ...productsState.products,
          result,
        ],
      );
      return;
    }
    productsState = productsState.copyWith(
      products: productsState.products
          .map((element) => element.id == idProduct ? result : element)
          .toList(),
      isLoading: false,
    );
    notifyListeners();
  }

  Future<bool> deleteProductById(int idProduct) async {
    final result = await productProvider.deleteProduct(idProduct);
    if (!result) return false;
    productsState = productsState.copyWith(
      products: productsState.products
          .where((element) => element.id != idProduct)
          .toList(),
    );
    notifyListeners();
    return true;
  }

  Future<void> getProductsAllProducts() async {
    productsState = productsState.copyWith(isLoading: true);
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products',
      {},
    );
    productsState = productsState.copyWith(
      products: productsModelFromJson(clientRequest!.body),
      isLoading: false,
    );
    notifyListeners();
  }

  Future<List<ProductModel>> searchProductsByName(String query) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products?search=$query',
      {},
    );
    return productsModelFromJson(clientRequest!.body);
  }

  Future<List<ProductModel>> getAllProducts() async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products',
      {},
    );
    return productsModelFromJson(clientRequest!.body);
  }
}

class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<ProductModel> products;

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
    List<ProductModel>? products,
  }) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
