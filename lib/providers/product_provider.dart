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
  ProductState _state = ProductState(
    id: '',
    product: null,
  );

  SelectedProductState selectProductState = SelectedProductState(
    product: null,
    isLoading: false,
  );

  Future<void> loadProduct(int? idProduct) async {
    try {
      selectProductState = selectProductState.copyWith(isLoading: true);
      if (idProduct == null) {
        selectProductState = selectProductState.copyWith(
          selectedProduct: SelectedProduct(
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

        // No notificar aquí, ya que no hay cambios relevantes
        return;
      }

      selectProductState = selectProductState.copyWith(isLoading: true);
      final clientRequest = await Request.sendRequestWithToken(
        RequestType.get,
        'products/$idProduct',
        {},
      );

      final product = productModelFromJson(clientRequest!.body);

      selectProductState = selectProductState.copyWith(
        product: product,
        isLoading: false,
        selectedProduct: SelectedProduct(
          idProduct: product.id,
          name: product.name,
          price: product.price,
          description: product.description,
          category: product.categories.first.id,
          idTags: [] /* product.tags.map((e) => e.id).toList() */,
          images: product.images.map((e) => e.src).toList(),
        ),
      );

      notifyListeners(); // Notificar después de completar la carga del producto
    } catch (e) {
      rethrow;
    }
  }

  void updateProductImage(String path) {
    selectProductState = selectProductState.copyWith(
      selectedProduct: selectProductState.selectedProduct!.copyWith(
        images: [...selectProductState.selectedProduct!.images, path],
      ),
    );
    notifyListeners();
  }

  Future<bool> deleteProduct(int idProduct) async {
    try {
      final clientRequest = await Request.sendRequestWithToken(
        RequestType.delete,
        'products/$idProduct',
        {},
      );

      return validateStatus(clientRequest!.statusCode);
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

      final productResult = productModelFromJson(clientRequest!.body);
      selectProductState = selectProductState.copyWith(
        isLoading: false,
        product: productResult,
      );
      notifyListeners();
      return productResult;
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

  SelectedProduct copyWith({
    String? name,
    String? price,
    String? description,
    int? category,
    List<String>? idTags,
    int? idProduct,
    List<String>? images,
  }) =>
      SelectedProduct(
        name: this.name,
        price: this.price,
        description: this.description,
        category: this.category,
        idTags: this.idTags,
        images: images ?? this.images,
        idProduct: this.idProduct,
      );
}

class SelectedProductState {
  final ProductModel? product;
  final SelectedProduct? selectedProduct;
  final bool isLoading;
  final bool isSaving;

  SelectedProductState({
    this.product,
    this.selectedProduct,
    this.isLoading = true,
    this.isSaving = false,
  });
  SelectedProductState copyWith({
    ProductModel? product,
    bool? isLoading,
    bool? isSaving,
    SelectedProduct? selectedProduct,
  }) =>
      SelectedProductState(
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
        selectedProduct: selectedProduct ?? this.selectedProduct,
      );
}
