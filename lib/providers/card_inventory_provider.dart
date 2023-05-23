part of 'providers.dart';

class CardInventoryProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  double total = 0;
  List<int> _productsId = [];
  ClientModel? _client;

  set setClient(ClientModel clientModel) {
    _client = clientModel;
    notifyListeners();
  }

  ClientModel? get getClient => _client;

  addProduct(ProductModel product) {
    if (_productsId.contains(product.id)) {
      products.removeWhere((element) => element.id == product.id);
      _productsId.remove(product.id);
    } else {
      products.add(product);
      _productsId.add(product.id);
    }
    getTotal();
    notifyListeners();
  }

  deleteProduct(ProductModel product) {
    if (_productsId.contains(product.id)) {
      products.removeWhere((element) => element.id == product.id);
      _productsId.remove(product.id);
    }
    getTotal();
    notifyListeners();
  }

  getTotal() {
    if (products.isEmpty) {
      total = 0;
    } else {
      total = products
          .map((e) => double.parse(e.price))
          .reduce((value, element) => value + element);
      products = products;
    }
  }

  double get getTotalValue => total;
  List<ProductModel> get getProducts => products;
  List<int> get getListProductsId => _productsId;

  clearProducts() {
    products = [];
    _productsId = [];
    _client = null;
    total = 0;
    notifyListeners();
  }

  clearClient() {
    _client = null;
    notifyListeners();
  }
}
