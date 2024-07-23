class TransactionModel {
  List<Data> data;

  TransactionModel({this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int usersId;
  String address;
  int totalPrice;
  String status;
  String payment;
  String paymentProof;
  void deletedAt;
  String createdAt;
  String updatedAt;
  List<Items> items;

  Data(
      {this.id,
      this.usersId,
      this.address,
      this.totalPrice,
      this.status,
      this.payment,
      this.paymentProof,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    address = json['address'];
    totalPrice = json['total_price'];
    status = json['status'];
    payment = json['payment'];
    paymentProof = json['payment_proof'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['users_id'] = usersId;
    data['address'] = address;
    data['total_price'] = totalPrice;
    data['status'] = status;
    data['payment'] = payment;
    data['payment_proof'] = paymentProof;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (items != null) {
      data['items'] = items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int id;
  int usersId;
  int productsId;
  int transactionsId;
  int quantity;
  String createdAt;
  String updatedAt;
  Product product;

  Items(
      {this.id,
      this.usersId,
      this.productsId,
      this.transactionsId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    productsId = json['products_id'];
    transactionsId = json['transactions_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['users_id'] = usersId;
    data['products_id'] = productsId;
    data['transactions_id'] = transactionsId;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  String name;
  int price;
  String description;
  String tags;
  int categoriesId;
  void deletedAt;
  String createdAt;
  String updatedAt;

  Product(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.tags,
      this.categoriesId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    tags = json['tags'];
    categoriesId = json['categories_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['tags'] = tags;
    data['categories_id'] = categoriesId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
