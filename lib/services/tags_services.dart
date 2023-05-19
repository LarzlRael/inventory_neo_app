part of 'services.dart';

class TagsServices {
  Future<TagsModel> getTagById(String categoryId) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products/tags/$categoryId',
      {},
    );
    return tagModelFromJson(clientRequest!.body);
  }

  Future<List<TagsModel>> getAllTags() async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products/tags',
      {},
    );
    return tagsModelFromJson(clientRequest!.body);
  }
}
