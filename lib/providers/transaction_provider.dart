import 'package:flutter/widgets.dart';
import 'package:jogjasport/models/transaction_model.dart';
import 'package:jogjasport/services/transaction_service.dart';

import '../models/cart_model.dart';

class TransactionProvider with ChangeNotifier {
  bool isLoading = false;
  List<Data> _transactions = [];

  List<Data> get transactions => _transactions;

  set transactions(List<Data> transactions) {
    _transactions = transactions;
    notifyListeners();
  }

  Future<void> getTransactions(String token) async {
    try {
      isLoading = true;
      List<Data> transactions =
          await TransactionService().getTransactions(token);
      _transactions = transactions;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e);
    }
  }

  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice,
      String address, String paymentProof, String shippingPrice) async {
    try {
      if (await TransactionService().checkout(
          token, carts, address, totalPrice, paymentProof, shippingPrice)) {
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
