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
    Map<String, dynamic> body, {
    bool useAuxiliarUrl = false,
  }) async {
    //headers with basic auth
    String username = dotenv.get('wc_username');
    String password = dotenv.get('wc_password');
    final token = await KeyValueStorageServiceImpl().getValue<String>('token');
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

    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final httpClient = new IOClient(ioc);
    switch (method) {
      case RequestType.get:
        res = await httpClient.get(uri, headers: headers);

        break;
      case RequestType.post:
        res = await httpClient.post(uri,
            body: jsonEncode(body), headers: headers);
        break;
      case RequestType.put:
        res =
            await httpClient.put(uri, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.delete:
        res = await httpClient.delete(uri, headers: headers);
    }
    return res;
  }

  static Future<http.Response> uploadFileRequest(
    RequestType requestType,
    String url,
    Map<String, String> otherFields,
    File file, {
    bool useAuxiliarUrl = false,
  }) async {
    late http.Response res;
    Uri uri = useAuxiliarUrl
        ? Uri.parse('${Environment.apiUrl}/$url')
        : Uri.parse('${Environment.baseURL}/$url');

    final mimeType = mime(file.path)!.split('/');
    final token = await KeyValueStorageServiceImpl().getValue<String>('token');
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
