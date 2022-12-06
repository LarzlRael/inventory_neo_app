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
}
