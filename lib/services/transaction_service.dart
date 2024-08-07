import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jogjasport/util.dart';

import '../models/cart_model.dart';
import '../models/transaction_model.dart';

class TransactionService {
  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice,
      String address, File? paymentProof) async {
    String base64File = "";
    if(paymentProof != null) {
      List<int> imageBytes = paymentProof.readAsBytesSync();
      base64File = base64Encode(imageBytes);
    }
    var url = '${Util.baseUrl}/checkout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'address': address,
      'items': carts
          .map(
            (cart) => {
              'id': cart.product?.id,
              'quantity': cart.quantity,
              'size': cart.sizeId,
              'color': cart.colorsId,
            },
          )
          .toList(),
      'status': 'SEDANG DIPROSES',
      'payment_proof': base64File,
      'total_price': totalPrice,
    });

    log(body);

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // ignore: avoid_print
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Melakukan Checkout');
    }
  }

  Future<List<Data>> getTransactions(String token) async {
    var url = '${Util.baseUrl}/your-order';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<Data> transactions =
          data.map((item) => Data.fromJson(item)).toList();
      return transactions;
    } else {
      throw Exception('Failed to get transactions');
    }
  }

  Future<bool> addComment({
    required String comment,
    required int rating,
    required int productId,
    required String token,
  }) async {
    var url = '${Util.baseUrl}/comment/${productId}';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'comment': comment,
      'rating': rating,
    });

    print('masuk sini');
    print(url);
    print(body);

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // ignore: avoid_print
    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
        'Ada Kesalahan',
      );
    }
  }

  Future<bool> updateTransaction({
    required String orderId,
    required String token,
  }) async {
    var url = '${Util.baseUrl}/transactions/update/${orderId}';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'status': 'SELESAI',
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // ignore: avoid_print
    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
        'Ada Kesalahan',
      );
    }
  }
}
