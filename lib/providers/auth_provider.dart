part of 'providers.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  AuthState authState = AuthState();

  final _storage = const FlutterSecureStorage();

  Future<bool> login(Map<String, dynamic> data) async {
    final post =
        await postAction('api/client/login', data, useAuxiliarUrl: true);
    final valid = validateStatus(post!.statusCode);
    if (valid) {
      final body = loginClientModelFromJson(post.body);

      authState = authState.copyWith(
        authStatus: AuthStatus.authenticated,
        user: body,
        isLogged: true,
      );
      await _storage.write(key: 'token', value: body!.token);
      notifyListeners();
    }
    return valid;
  }

  logout() {
    authState = authState.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      isLogged: false,
    );
    notifyListeners();
    _storage.delete(key: 'token');
  }

  Future<bool> renewToken() async {
    final resp = await Request.sendRequestWithToken(RequestType.get,
        'api/client/renew', {}, await _storage.read(key: 'token'),
        useAuxiliarUrl: true);

    if (validateStatus(resp!.statusCode)) {
      final body = loginClientModelFromJson(resp.body);

      await _storage.write(key: 'token', value: body!.token);
      authState = authState.copyWith(
        authStatus: AuthStatus.authenticated,
        user: body,
        isLogged: true,
      );
      notifyListeners();
      return true;
    } else {
      logout();
      return false;
    }
  }
}

class AuthState {
  final AuthStatus authStatus;
  final LoginClientModel? user;
  final String errorMessage;
  final bool isLogged;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
    this.isLogged = false,
  });
  AuthState copyWith({
    AuthStatus? authStatus,
    LoginClientModel? user,
    String? errorMessage,
    bool? isLogged,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
        isLogged: isLogged ?? this.isLogged,
      );
}
