part of 'services.dart';

class TagsServices {
  Future<TagModel> getTagById(int categoryId) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products/tags/$categoryId',
      {},
    );
    return tagModelFromJson(clientRequest!.body);
  }

  Future<List<TagModel>> getAllTags() async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products/tags',
      {},
    );
    return tagsModelFromJson(clientRequest!.body);
  }
}
