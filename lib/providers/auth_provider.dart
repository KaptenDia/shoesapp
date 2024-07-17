// @dart=2.9
import 'package:flutter/material.dart';
import 'package:jogjasport/models/user_models.dart';
import 'package:jogjasport/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;
  TextEditingController addressController = TextEditingController();
  bool isChanged = false;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String name,
    String username,
    String address,
    String phone,
    String email,
    String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        address: address,
        phone: phone,
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String email,
    String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  void changeAddress(String newAddress) {
    addressController.text = newAddress;
    isChanged = true;
    notifyListeners();
  }
}
