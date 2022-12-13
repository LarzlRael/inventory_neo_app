part of 'services.dart';

class ProductsServices {
  Future<List<ProductsModel>> getProductsByCategory(String category) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products?category=$category',
      {},
      'xd',
    );
    return productsModelFromJson(clientRequest!.body);
  }

  Future<List<ProductsModel>> getAllProducts() async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products',
      {},
      'xd',
    );
    return productsModelFromJson(clientRequest!.body);
  }

  Future<List<ProductsModel>> searchProductsByName(String query) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products?search=$query',
      {},
      'xd',
    );
    return productsModelFromJson(clientRequest!.body);
  }

  Future<bool> createProduct(Map<String, dynamic> body) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.post,
      'products',
      body,
      'xd',
    );
    return validateStatus(clientRequest!.statusCode);
  }

  Future<bool> deleteProduct(String idProduct) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.delete,
      'products/$idProduct',
      {},
      'xd',
    );
    return validateStatus(clientRequest!.statusCode);
  }
}
