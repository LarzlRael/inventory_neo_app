part of 'services.dart';

Future<http.Response?> getAction(String url) async {
  return await Request.sendRequestWithToken(RequestType.get, url, {}, '');
}

Future<http.Response?> postAction(String url, Map<String, dynamic> body) async {
  return await Request.sendRequestWithToken(RequestType.post, url, body, '');
}

Future<http.Response?> putAction(String url, Map<String, dynamic> body) async {
  return await Request.sendRequest(RequestType.put, url, body);
}

Future<http.Response?> deleteAction(String url) async {
  return await Request.sendRequest(RequestType.delete, url, {});
}
