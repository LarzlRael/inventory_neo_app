part of 'services.dart';

const _storage = FlutterSecureStorage();

Future<http.Response?> getAction(
  String url, {
  bool useAuxiliarUrl = false,
}) async {
  return await Request.sendRequestWithToken(
    RequestType.get,
    url,
    {},
    await _storage.read(key: 'token'),
    useAuxiliarUrl: useAuxiliarUrl,
  );
}

Future<http.Response?> postAction(
  String url,
  Map<String, dynamic> body, {
  bool useAuxiliarUrl = false,
}) async {
  return await Request.sendRequestWithToken(
      RequestType.post, url, body, await _storage.read(key: 'token'),
      useAuxiliarUrl: useAuxiliarUrl);
}

Future<http.Response?> putAction(String url, Map<String, dynamic> body,
    {bool useAuxiliarUrl = false}) async {
  return await Request.sendRequestWithToken(
      RequestType.put, url, body, await _storage.read(key: 'token'),
      useAuxiliarUrl: useAuxiliarUrl);
}

Future<http.Response?> deleteAction(
  String url, {
  bool useAuxiliarUrl = false,
}) async {
  return await Request.sendRequestWithToken(
      RequestType.delete, url, {}, await _storage.read(key: 'token'),
      useAuxiliarUrl: useAuxiliarUrl);
}
