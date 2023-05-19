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

  ProductProvider() {
    productsProvider = ProductsProvider();
  }
  Future<ProductModel> loadProduct(String idProduct) async {
    try {
      final clientRequest = await Request.sendRequestWithToken(
        RequestType.get,
        'products/$idProduct',
        {},
      );
      return productModelFromJson(clientRequest!.body);
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
