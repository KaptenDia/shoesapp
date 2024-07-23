// @dart=2.9

import 'dart:convert';

import '../models/user_models.dart';
import 'package:http/http.dart' as http;

import '../util.dart';

class AuthService {
  Future<UserModel> register({
    String name,
    String username,
    String address,
    String phone,
    String email,
    String password,
  }) async {
    var url = '${Util.baseUrl}/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'address': address,
      'phone': phone,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // ignore: avoid_print
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      var errorMessage = jsonDecode(response.body)['message'];
      throw Exception(errorMessage);
    }
  }

  Future<UserModel> login({
    String email,
    String password,
  }) async {
    var url = '${Util.baseUrl}/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // ignore: avoid_print
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception(
        'Ada Kesalahan Saat Login',
      );
    }
  }

  Future<UserModel> updateProfile({
    String name,
    String address,
    String phone,
    String email,
    String token,
  }) async {
    var url = '${Util.baseUrl}/update-user';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print('Response body: ${response.body}');

    try {
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        var data = responseBody['data'];
        if (data != null) {
          UserModel user = UserModel.fromJson(data);
          return user;
        } else {
          throw Exception('Data is null');
        }
      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody['message'];
        throw Exception(errorMessage ?? 'Unknown error');
      }
    } catch (e) {
      throw Exception('Failed to parse response: $e');
    }
  }
}
