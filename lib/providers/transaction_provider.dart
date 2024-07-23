import 'package:flutter/widgets.dart';
import 'package:jogjasport/models/transaction_model.dart';
import 'package:jogjasport/services/transaction_service.dart';

import '../models/cart_model.dart';

class TransactionProvider with ChangeNotifier {
  List<Data> _transactions = [];

  List<Data> get transactions => _transactions;

  set transactions(List<Data> transactions) {
    _transactions = transactions;
    notifyListeners();
  }

  Future<void> getTransactions(String token) async {
    try {
      List<Data> transactions =
          await TransactionService().getTransactions(token);
      _transactions = transactions;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice,
      String address, String paymentProof) async {
    try {
      if (await TransactionService()
          .checkout(token, carts, totalPrice, address, paymentProof)) {
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
