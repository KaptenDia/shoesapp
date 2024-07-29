import 'package:flutter/cupertino.dart';
import 'package:jogjasport/models/cart_model.dart';
import 'package:jogjasport/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];
  String imgProofPath;
  String imgProofName;

  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addCart(
    ProductModel product,
    int size,
    String color,
  ) {
    if (productExist(product)) {
      int index =
          _carts.indexWhere((element) => element.product.id == product.id);
      _carts[index].quantity++;
    } else {
      _carts.add(
        CartModel(
          id: _carts.length,
          product: product,
          quantity: 1,
          size: size,
          color: color,
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
    if (_carts[id].quantity < _carts[id].product.stock) {
      _carts[id].quantity++;
    }
    notifyListeners();
  }

  reduceQuantity(int id) {
    _carts[id].quantity--;
    if (_carts[id].quantity == 0) {
      _carts.removeAt(id);
    }
    notifyListeners();
  }

  totalItems() {
    int total = 0;
    for (var item in _carts) {
      total += item.quantity;
    }
    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _carts) {
      double price = double.parse(item.product.price.toString() ?? 0);
      total += item.quantity * price;
    }
    return total + totalShipping();
  }

  totalShipping() {
    double total = 0;
    for (var item in _carts) {
      double shippingPrice =
          double.parse(item.product.shippingPrice.toString() ?? 0) ?? 0;
      total += item.quantity * shippingPrice;
    }
    return total;
  }

  productExist(ProductModel product) {
    if (_carts.indexWhere((element) => element.product.id == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }
}
