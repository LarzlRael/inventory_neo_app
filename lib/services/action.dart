part of 'services.dart';

Future<http.Response?> getAction(
  String url, {
  bool useAuxiliarUrl = false,
}) async {
  return await Request.sendRequestWithToken(
    RequestType.get,
    url,
    {},
    useAuxiliarUrl: useAuxiliarUrl,
  );
}

Future<http.Response?> postAction(
  String url,
  Map<String, dynamic> body, {
  bool useAuxiliarUrl = false,
}) async {
  return await Request.sendRequestWithToken(
    RequestType.post,
    url,
    body,
    useAuxiliarUrl: useAuxiliarUrl,
  );
}

Future<http.Response?> putAction(String url, Map<String, dynamic> body,
    {bool useAuxiliarUrl = false}) async {
  return await Request.sendRequestWithToken(
    RequestType.put,
    url,
    body,
    useAuxiliarUrl: useAuxiliarUrl,
  );
}

Future<http.Response?> deleteAction(
  String url, {
  bool useAuxiliarUrl = false,
}) async {
  return await Request.sendRequestWithToken(RequestType.delete, url, {},
      useAuxiliarUrl: useAuxiliarUrl);
}
