part of 'providers.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  AuthState authState = AuthState();
  AuthStatus get authStatus => authState.authStatus;
  KeyValueStorageServiceImpl keyValueStorageService =
      KeyValueStorageServiceImpl();

  Future<bool> login(Map<String, dynamic> data) async {
    final post = await postAction('/client/login', data, useAuxiliarUrl: true);
    final valid = validateStatus(post!.statusCode);
    if (valid) {
      final body = loginClientModelFromJson(post.body);

      authState = authState.copyWith(
        authStatus: AuthStatus.authenticated,
        user: body,
        isLogged: true,
      );

      await keyValueStorageService.setKeyValue<String>('token', body!.token!);
      notifyListeners();
    }
    return valid;
  }

  logout() async {
    await keyValueStorageService.removeKey('token');
    authState = authState.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      isLogged: false,
    );
    notifyListeners();
  }

  Future<bool> renewToken() async {
    await keyValueStorageService.getValue<String>('token');
    final resp = await Request.sendRequestWithToken(
      RequestType.get,
      '/client/renew',
      {},
      useAuxiliarUrl: true,
    );

    if (validateStatus(resp!.statusCode)) {
      final body = loginClientModelFromJson(resp.body);

      await keyValueStorageService.setKeyValue<String>('token', body!.token!);

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
