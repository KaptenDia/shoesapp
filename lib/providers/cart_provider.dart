import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:jogjasport/models/cart_model.dart';
import 'package:jogjasport/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];
  String? imgProofPath;
  String? imgProofName;
  File? imageFile;

  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addCart(ProductModel product, int colorsId, int sizeId) {
    if (productExist(product)) {
      int index = _carts.indexWhere((element) => element.product!.id == product.id);
      _carts[index].quantity = (_carts[index].quantity ?? 0) + 1;
    } else {
      _carts.add(
        CartModel(
          id: _carts.length,
          product: product,
          quantity: 1,
          colorsId: colorsId,
          sizeId: sizeId
        ),
      );
    }

    notifyListeners();
  }

  removeCart(int id) {
    _carts.removeAt(id);
    notifyListeners();
  }

  addQuantity(int id) {
    _carts[id].quantity = (_carts[id].quantity ?? 0) + 1;
    notifyListeners();
  }

  reduceQuantity(int id) {
    _carts[id].quantity = (_carts[id].quantity ?? 0) - 1;
    if (_carts[id].quantity == 0) {
      _carts.removeAt(id);
    }
    notifyListeners();
  }

  totalItems() {
    int total = 0;
    for (var item in _carts) {
      total += (item.quantity ?? 0);
    }
    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _carts) {
      total += ((item.quantity ?? 0) * (item.product?.price ?? 0));
    }
    return total;
  }

  productExist(ProductModel product) {
    if (_carts.indexWhere((element) => element.product?.id == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }

  totalShipping(double total) {
    double shipping = 0;
    if (total >= 150000 && total < 1000000) {
      shipping = total * 0.03;
    } else if (total >= 1000000 && total < 5000000) {
      shipping = total * 0.02;
    } else if (total >= 5000000 && total <= 10000000) {
      shipping = total * 0.01;
    }
    return shipping;
  }
}
