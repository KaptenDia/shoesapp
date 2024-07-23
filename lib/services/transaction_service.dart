import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jogjasport/util.dart';

import '../models/cart_model.dart';
import '../models/transaction_model.dart';

class TransactionService {
  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice,
      String address, String paymentProof) async {
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
              'id': cart.product.id,
              'quantity': cart.quantity,
            },
          )
          .toList(),
      'status': 'PENDING',
      'payment_proof': paymentProof,
      'total_price': totalPrice,
    });

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
}
