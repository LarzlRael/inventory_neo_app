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
}
