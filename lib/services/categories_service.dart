part of 'services.dart';

class CategoriesServices {
  Future<List<CategoriesModel>> getCategories() async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products/categories',
      {},
      'xd',
    );
    return categoriesModelFromJson(clientRequest!.body);
  }

  Future<bool> newCategory(Map<String, dynamic> body) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.post,
      'products/categories',
      body,
      'xd',
    );
    return validateStatus(clientRequest!.statusCode);
  }
}
