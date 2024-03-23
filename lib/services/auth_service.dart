import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  String _username = '';
  String _password = '';
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String _errorMessage = '';

  String get username => _username;
  String get password => _password;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String get errorMessage => _errorMessage;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void login() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      if (_username == 'admin' && _password == 'password') {
        _isLoggedIn = true;
        _isLoading = false;
        _errorMessage = '';
      } else {
        _isLoggedIn = false;
        _isLoading = false;
        _errorMessage = 'Invalid username or password';
      }
      notifyListeners();
    });
  }

  void logout() {
    _isLoggedIn = false;
    _username = '';
    _password = '';
    notifyListeners();
  }
}
