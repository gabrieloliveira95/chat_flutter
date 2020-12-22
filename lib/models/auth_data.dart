import 'dart:io';

enum AuthMode {
  LOGIN,
  SIGNUP,
}

class AuthData {
  String name;
  String email;
  String password;
  File image;
  AuthMode _mode = AuthMode.LOGIN;

  AuthData({
    this.email,
    this.name,
    this.password,
  });

  bool get isSignUp {
    return _mode == AuthMode.SIGNUP;
  }

  bool get isLogin {
    return _mode == AuthMode.LOGIN;
  }

  void toogleMode() {
    _mode == AuthMode.LOGIN ? _mode = AuthMode.SIGNUP : _mode = AuthMode.LOGIN;
  }
}
