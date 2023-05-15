part of 'providers.dart';

class ProductProvider extends ChangeNotifier {
  late ProductsProvider productsProvider;

  ProductProvider() {
    productsProvider = ProductsProvider();
  }

  Future<bool> deleteProduct(String idProduct) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.delete,
      'products/$idProduct',
      {},
      'xd',
    );

    productsProvider.deleteProductById(idProduct);
    return validateStatus(clientRequest!.statusCode);
  }

  createOrUpdateProduct(
    Map<String, dynamic> body, {
    int? idProduct,
  }) async {
    final clientRequest = await Request.sendRequestWithToken(
      idProduct == null ? RequestType.put : RequestType.post,
      idProduct == null ? 'products' : 'products/$idProduct',
      body,
      'xd',
    );
    final valid = validateStatus(clientRequest!.statusCode);
  }
}
