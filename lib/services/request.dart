part of 'services.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class Request {
  String uri = Environment.baseURL;

  static Future<http.Response?> sendRequest(
    RequestType method,
    String url,
    Map<String, dynamic>? body,
  ) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    Uri uri = Uri.parse('${Environment.baseURL}/$url');
    late http.Response res;
    switch (method) {
      case RequestType.get:
        res = await http.get(uri);
        break;
      case RequestType.post:
        res = await http.post(uri, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.put:
        res = await http.put(uri, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.delete:
        res = await http.delete(uri);
    }
    return res;
  }

  static Future<http.Response?> sendRequestWithToken(
    RequestType method,
    String url,
    Map<String, dynamic> body,
    String? token, {
    bool useAuxiliarUrl = false,
  }) async {
    //headers with basic auth
    String username = dotenv.get('wc_username');
    String password = dotenv.get('wc_password');

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': useAuxiliarUrl ? 'Bearer $token' : basicAuth,
    };

    Uri uri = useAuxiliarUrl
        ? Uri.parse('${Environment.apiUrl}/$url')
        : Uri.parse('${Environment.baseURL}/$url');
    late http.Response res;
    switch (method) {
      case RequestType.get:
        res = await http.get(uri, headers: headers);
        break;
      case RequestType.post:
        res = await http.post(uri, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.put:
        res = await http.put(uri, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.delete:
        res = await http.delete(uri, headers: headers);
    }
    return res;
  }

  static Future<http.Response> uploadFileRequest(
    RequestType requestType,
    String url,
    Map<String, String> otherFields,
    File file,
    String token, {
    bool useAuxiliarUrl = false,
  }) async {
    late http.Response res;
    Uri uri = useAuxiliarUrl
        ? Uri.parse('${Environment.apiUrl}/$url')
        : Uri.parse('${Environment.baseURL}/$url');

    final mimeType = mime(file.path)!.split('/');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final uploadFile = await http.MultipartFile.fromPath(
      'image',
      file.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    final uploadPostRequest = http.MultipartRequest(
      requestType == RequestType.post ? 'POST' : 'PUT',
      uri,
    );
    uploadPostRequest.headers.addAll(headers);
    uploadPostRequest.files.add(uploadFile);
    uploadPostRequest.fields.addAll(otherFields);
    final streamResponse = await uploadPostRequest.send();
    res = await http.Response.fromStream(streamResponse);

    return res;
  }
}
