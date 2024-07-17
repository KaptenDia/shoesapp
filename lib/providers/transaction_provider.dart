import 'package:flutter/widgets.dart';
import 'package:jogjasport/services/transaction_service.dart';

import '../models/cart_model.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice,
      String address) async {
    try {
      if (await TransactionService()
          .checkout(token, carts, totalPrice, address)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }
}
