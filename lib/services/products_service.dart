part of 'services.dart';

class ProductsServices {
  /* Future<List<ProductsModel>> getProductsByCategory(int category) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products?category=$category',
      {},
    );
    return productsModelFromJson(clientRequest!.body);
  } */

  /*  Future<List<ProductsModel>> getAllProducts() async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products',
      {},
    );
    return productsModelFromJson(clientRequest!.body);
  } */

/*   Future<List<ProductsModel>> searchProductsByName(String query) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products?search=$query',
      {},
    );
    return productsModelFromJson(clientRequest!.body);
  } */

  /* Future<bool> createOrUpdateProduct(
    Map<String, dynamic> body, {
    bool edit = false,
    int? idProduct,
  }) async {
    final clientRequest = await Request.sendRequestWithToken(
      edit ? RequestType.put : RequestType.post,
      edit ? 'products/$idProduct' : 'products',
      body,
      'xd',
    );
    return validateStatus(clientRequest!.statusCode);
  } */

/*   Future<bool> deleteProduct(String idProduct) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.delete,
      'products/$idProduct',
      {},
    );
    return validateStatus(clientRequest!.statusCode);
  } */
}
