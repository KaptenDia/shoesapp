class TransactionModel {
  Meta meta;
  List<Items> data; // Changed from Data to List<Items>

  TransactionModel({this.meta, this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    data = (json['data'] as List).map((item) => Items.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((item) => item.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int code;
  String status;
  String message;

  Meta({this.code, this.status, this.message});

  Meta.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Data {
  int usersId;
  String address;
  String paymentProof;
  String totalPrice; // Make sure this is a String
  String status;
  String updatedAt;
  String createdAt;
  int id;
  List<Items> items;

  Data({
    this.usersId,
    this.address,
    this.paymentProof,
    this.totalPrice,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      usersId: json['users_id'],
      address: json['address'],
      paymentProof: json['payment_proof'],
      totalPrice: json['total_price'].toString(), // Ensuring string type
      status: json['status'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
      items: (json['items'] as List).map((i) => Items.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users_id': usersId,
      'address': address,
      'payment_proof': paymentProof,
      'total_price': totalPrice,
      'status': status,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
      'items': items.map((i) => i.toJson()).toList(),
    };
  }
}

class Items {
  int id;
  int brandId;
  String type;
  int price; // Can remain as int since JSON response indicates it's a number
  int shippingPrice;
  int stock;
  String rating;
  String description;
  String tags;
  int categoriesId;
  String deletedAt;
  String createdAt;
  String updatedAt;
  int transactionsId;
  String quantity; // Ensure this is a string

  Items({
    this.id,
    this.brandId,
    this.type,
    this.price,
    this.shippingPrice,
    this.stock,
    this.rating,
    this.description,
    this.tags,
    this.categoriesId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.transactionsId,
    this.quantity,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      brandId: json['brand_id'],
      type: json['type'],
      price: json['price'],
      shippingPrice: json['shipping_price'],
      stock: json['stock'],
      rating: json['rating'],
      description: json['description'],
      tags: json['tags'],
      categoriesId: json['categories_id'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      transactionsId: json['transactions_id'],
      quantity: json['quantity'].toString(), // Ensuring string type
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand_id': brandId,
      'type': type,
      'price': price,
      'shipping_price': shippingPrice,
      'stock': stock,
      'rating': rating,
      'description': description,
      'tags': tags,
      'categories_id': categoriesId,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'transactions_id': transactionsId,
      'quantity': quantity,
    };
  }
}
