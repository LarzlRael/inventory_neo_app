import 'package:flutter/material.dart';
import 'package:inventory_app/providers/providers.dart';

class GoRouterNotifier extends ChangeNotifier {
  final AuthProvider _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener(() {
      authStatus = _authNotifier.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
