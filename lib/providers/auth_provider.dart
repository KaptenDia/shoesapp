import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jogjasport/models/user_models.dart';
import 'package:jogjasport/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  TextEditingController addressController = TextEditingController();
  bool isChanged = false;

  UserModel get user => _user!;

  set user(UserModel user) {
    _user = user;
    log(_user.toString());
    notifyListeners();
  }

  Future<void> register({
    required String name,
    required String address,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        address: address,
        phone: phone,
        email: email,
        password: password,
      );

      _user = user;
    } catch (e) {
      // Re-throw the exception to be caught in handleSignUp
      rethrow;
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String address,
    required String phone,
    required String email,
    required String token,
  }) async {
    try {
      UserModel user = await AuthService().updateProfile(
        name: name,
        address: address,
        phone: phone,
        email: email,
        token: token,
      );

      _user = user;
      notifyListeners();
      return true;
    } catch (e) {
      // Print the error for debugging purposes
      print('Error updating profile: $e');
      rethrow; // Ensure the exception is rethrown to be handled by the caller
    }
  }

  Future<bool> login({
    required String email,
    required String password,
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
