class TransactionModel {
  List<Data>? data;

  TransactionModel({this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? usersId;
  String? address;
  int? totalPrice;
  String? status;
  String? payment;
  String? paymentProof;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

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
        items?.add(Items.fromJson(v));
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
      data['items'] = items?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? usersId;
  int? productsId;
  int? transactionsId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Product? product;
  SizeData? size;
  ColorsData? color;


  Items(
      {this.id,
      this.usersId,
      this.productsId,
      this.transactionsId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.size,
      this.color,
      this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    productsId = json['products_id'];
    transactionsId = json['transactions_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    size = json['size'] != null ? new SizeData.fromJson(json['size']) : null;
    color = json['color'] != null ? new ColorsData.fromJson(json['color']) : null;
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
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    if (product != null) {
      data['product'] = product?.toJson();
    }
    return data;
  }
}

class SizeData {
  int? id;
  int? size;
  int? productId;
  String? createdAt;
  String? updatedAt;

  SizeData({this.id, this.size, this.productId, this.createdAt, this.updatedAt});

  SizeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ColorsData {
  int? id;
  String? color;
  int? productId;
  String? createdAt;
  String? updatedAt;

  ColorsData({this.id, this.color, this.productId, this.createdAt, this.updatedAt});

  ColorsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color'] = this.color;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? price;
  String? description;
  String? tags;
  int? categoriesId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Galleries>? galleries;
  List<Comments>? comments;

  Product(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.tags,
      this.categoriesId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.galleries,
      this.comments
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? json['type'];
    price = json['price'];
    description = json['description'];
    tags = json['tags'];
    categoriesId = json['categories_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['galleries'] != null) {
      galleries = <Galleries>[];
      json['galleries'].forEach((v) {
        galleries!.add(new Galleries.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
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
    if (this.galleries != null) {
      data['galleries'] = this.galleries!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Galleries {
  int? id;
  int? productsId;
  String? url;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Galleries(
      {this.id,
        this.productsId,
        this.url,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Galleries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productsId = json['products_id'];
    url = json['url'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['products_id'] = this.productsId;
    data['url'] = this.url;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Comments {
  int? id;
  int? productId;
  int? customerId;
  String? comment;
  String? rating;
  String? createdAt;
  String? updatedAt;

  Comments(
      {this.id,
        this.productId,
        this.customerId,
        this.comment,
        this.rating,
        this.createdAt,
        this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    comment = json['comment'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
