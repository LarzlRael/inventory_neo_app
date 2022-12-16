part of 'services.dart';

class ProductsServices {
  Future<List<ProductsModel>> getProductsByCategory(int category) async {
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

  Future<bool> createOrUpdateProduct(
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

/* {"code":"rest_invalid_param","message":"Par\u00e1metro(s) no v\u00e1lido(s): categories, tags","data":{"status":400,"params":{"categories":"categories[0][id] no es del tipo integer.","tags":"tags[0][id] no es del tipo integer."},"details":{"categories":{"code":"rest_invalid_type","message":"categories[0][id] no es del tipo integer.","data":{"param":"categories[0][id]"}},"tags":{"code":"rest_invalid_type","message":"tags[0][id] no es del tipo integer.","data":{"param":"tags[0][id]"}}}}} */