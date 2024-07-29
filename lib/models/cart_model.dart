import 'package:jogjasport/models/product_model.dart';

class CartModel {
  int id;
  ProductModel product;
  int quantity;
  int size;
  String color;

  CartModel({
    this.id,
    this.product,
    this.quantity,
    this.size,
    this.color,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
    quantity = json['quantity'];
    size = json['size'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }

  getTotalPrice() {
    return product.price * quantity;
  }
}
