part of 'providers.dart';

class AuthProvider extends ChangeNotifier {
  bool isLogged = false;
  final _storage = const FlutterSecureStorage();

  Future<bool> login(Map<String, dynamic> data) async {
    final post =
        await postAction('api/client/login', data, useAuxiliarUrl: true);
    final valid = validateStatus(post!.statusCode);
    if (valid) {
      final body = loginClientModelFromJson(post.body);
      isLogged = true;
      notifyListeners();
      await _storage.write(key: 'token', value: body.token);
    }
    return valid;
  }

  logout() {
    isLogged = false;
    notifyListeners();
    _storage.delete(key: 'token');
  }

  Future<bool> renewToken() async {
    final resp = await Request.sendRequestWithToken(RequestType.get,
        'api/client/renew', {}, await _storage.read(key: 'token'),
        useAuxiliarUrl: true);

    if (validateStatus(resp!.statusCode)) {
      final body = loginClientModelFromJson(resp.body);
      isLogged = true;
      notifyListeners();
      await _storage.write(key: 'token', value: body.token);
      return true;
    } else {
      isLogged = false;
      logout();
      return false;
    }
  }
}
