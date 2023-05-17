part of 'providers.dart';

class ProductProvider extends ChangeNotifier {
  late ProductsProvider productsProvider;

  ProductProvider() {
    productsProvider = ProductsProvider();
  }

  Future<ProductModel> deleteProduct(String idProduct) async {
    try {
      final clientRequest = await Request.sendRequestWithToken(
        RequestType.delete,
        'products/$idProduct',
        {},
        'xd',
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
        'xd',
      );
      return productModelFromJson(clientRequest!.body);
      /* final valid = validateStatus(clientRequest!.statusCode); */
    } catch (e) {
      rethrow;
    }
  }
}
