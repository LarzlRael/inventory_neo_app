part of 'blocs.dart';

class ProductsBloc {
  static final ProductsBloc _singleton = ProductsBloc._internal();
  ProductsBloc._internal();

  factory ProductsBloc() {
    return _singleton;
  }
  final _productsController = StreamController<List<ProductsModel>>.broadcast();

  Stream<List<ProductsModel>> get productsStream => _productsController.stream;

  /* void getProducts() async {
    _productsController.sink.add(await _productsServices.getAllProducts());
  }

  Future<bool> deleteProduct(String id, String urlImage) async {
    final res = await _productsServices.deleteProduct(id);
    getProducts();
    return res;
  } */

  void dispose() {
    _productsController.close();
  }
}
