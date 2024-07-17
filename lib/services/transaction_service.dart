import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/cart_model.dart';

class TransactionService {
  String baseUrl = 'https://235c-114-10-147-154.ngrok-free.app/api';

  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice,
      String address) async {
    var url = '$baseUrl/checkout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
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
      'total_price': totalPrice,
      'shipping_price': 0,
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
}
