import 'package:couple_planet/app/services/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignInScreenViewModel extends BaseViewModel {
  SignInScreenViewModel();

  String title = "Couples Planet".toUpperCase();
  String subTitle = "your search ends here".toUpperCase();

  String _emailId = '';
  String _password = '';
  bool isLoading = false;

  String get emailId => _emailId;
  String get password => _password;

  set emailId(String value) {
    _emailId = value;
  }

  set password(String value) {
    _password = value;
  }

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void onPasswordVisibilityChanged() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void updateIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<String> signInUser() async {
    print('SIGN IN USER');

    if (_emailId == '' || _password == '') {
      print('SIGN IN Empty');
      return 'EMPTY';
    } else {
      print('Doing');
      String result = await FirebaseAuthService()
          .signIn(email: _emailId, password: _password);
      return result;
    }
  }
}
