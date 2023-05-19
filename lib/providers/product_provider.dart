part of 'providers.dart';

class ItemDetails {
  int? idProduct;
  String name;
  String price;
  String description;
  int category;
  List<String> idTags;
  List<String> images = [];
  ItemDetails({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.idTags,
    required this.images,
    this.idProduct,
  });
}

class ProductProvider extends ChangeNotifier {
  late ProductsProvider productsProvider;

  ProductState _state = ProductState(
    id: '',
    product: null,
  );

  SelectedProductState selectProductState = SelectedProductState(
    product: null,
    isLoading: false,
  );

  ProductProvider() {
    productsProvider = ProductsProvider();
  }
  Future<void> loadProduct(int? idProduct) async {
    try {
      selectProductState = selectProductState.copyWith(isLoading: true);
      if (idProduct == null) {
        final emptySelectedProduct = SelectedProductState(
          product: SelectedProduct(
            idProduct: null,
            name: '',
            price: '',
            description: '',
            category: 0,
            idTags: [],
            images: [],
          ),
          isLoading: false,
        );
        selectProductState = selectProductState.copyWith(
          product: emptySelectedProduct.product,
          isLoading: false,
        );
        // No notificar aquí, ya que no hay cambios relevantes
        return;
      }

      final clientRequest = await Request.sendRequestWithToken(
        RequestType.get,
        'products/$idProduct',
        {},
      );

      final product = productModelFromJson(clientRequest!.body);

      final productSelected = SelectedProductState(
        product: SelectedProduct(
          idProduct: product.id,
          name: product.name,
          price: product.price,
          description: product.description,
          category: product.categories.first.id,
          idTags: [] /* product.tags.map((e) => e.id).toList() */,
          images: product.images.map((e) => e.src).toList(),
        ),
      );

      selectProductState = selectProductState.copyWith(
        product: productSelected.product,
        isLoading: false,
      );
      notifyListeners(); // Notificar después de completar la carga del producto
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> deleteProduct(String idProduct) async {
    try {
      final clientRequest = await Request.sendRequestWithToken(
        RequestType.delete,
        'products/$idProduct',
        {},
      );

      productsProvider.deleteProductById(idProduct);
      return productModelFromJson(clientRequest!.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> createOrUpdateProduct(
    Map<String, dynamic> body, {
    int? idProduct,
  }) async {
    try {
      final requestType =
          idProduct == null ? RequestType.post : RequestType.put;
      final clientRequest = await Request.sendRequestWithToken(
        requestType,
        idProduct == null ? 'products' : 'products/$idProduct',
        body,
      );
      return productModelFromJson(clientRequest!.body);
      /* final valid = validateStatus(clientRequest!.statusCode); */
    } catch (e) {
      rethrow;
    }
  }
}

class ProductState {
  final String id;
  final ItemDetails? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });
  ProductState copyWith({
    String? id,
    ItemDetails? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}

class SelectedProduct {
  int? idProduct;
  String name;
  String price;
  String description;
  int category;
  List<String> idTags;
  List<String> images = [];
  SelectedProduct({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.idTags,
    required this.images,
    this.idProduct,
  });
}

class SelectedProductState {
  final SelectedProduct? product;
  final bool isLoading;
  final bool isSaving;

  SelectedProductState({
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });
  SelectedProductState copyWith({
    SelectedProduct? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      SelectedProductState(
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
