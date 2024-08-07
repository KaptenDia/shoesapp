import 'package:jogjasport/models/product_model.dart';

class CartModel {
  int? id;
  ProductModel? product;
  int? quantity;
  int? sizeId;
  int? colorsId;

  CartModel({
    this.id,
    this.product,
    this.quantity,
    this.sizeId,
    this.colorsId,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
    quantity = json['quantity'];
    sizeId = json['size'];
    colorsId = json['colors'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product?.toJson(),
      'quantity': quantity,
      'size': sizeId,
      'colors': colorsId,
    };
  }

  getTotalPrice() {
    return (product?.price ?? 0) * (quantity ?? 0);
  }
}
