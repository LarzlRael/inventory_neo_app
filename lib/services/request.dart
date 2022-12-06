part of 'services.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class Request {
  String uri = '${Environment.serverHttpUrl}/';

  static Future<http.Response?> sendRequest(
    RequestType method,
    String url,
    Map<String, String>? body,
  ) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    Uri uri = Uri.parse('${Environment.serverHttpUrl}/$url');
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
    String? token,
  ) async {
    //headers with basic auth
    String username = dotenv.get('wc_username');
    String password = dotenv.get('wc_password');

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth,
    };

    final Uri uri = Uri.parse('${Environment.serverHttpUrl}/$url');
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

  /* static Future<http.Response> sendRequestWithFile(
    String method,
    String url,
    Map<String, String> otherFields,
    File file,
    String token,
  ) async {
    late http.Response res;
    final Uri uri = Uri.parse('${Environment.serverHttpUrl}/$url');
    final mimeType = mime(file.path)!.split('/');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final uploadFile = await http.MultipartFile.fromPath(
      'file',
      file.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    final uploadPostRequest = http.MultipartRequest(
      method,
      uri,
    );
    uploadPostRequest.headers.addAll(headers);
    uploadPostRequest.files.add(uploadFile);
    uploadPostRequest.fields.addAll(otherFields);
    final streamResponse = await uploadPostRequest.send();
    res = await http.Response.fromStream(streamResponse);

    return res;
  } */
}
