import 'package:flutter/material.dart';
import 'package:inventory_app/models/models.dart';

class CardInventoryProvider extends ChangeNotifier {
  List<ProductsModel> products = [];
  double total = 0;
  List<int> _productsId = [];
  addProduct(ProductsModel product) {
    if (_productsId.contains(product.id)) {
      products.remove(product);
      _productsId.remove(product.id);
    } else {
      products.add(product);
      _productsId.add(product.id);
    }
    debugPrint(_productsId.toString());
    debugPrint('total productsId: ${_productsId.length}');
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
  List<ProductsModel> get getProducts => products;
  List<int> get getListProductsId => _productsId;

  clearProducts() {
    products = [];
    _productsId = [];
    total = 0;
    notifyListeners();
  }
}
