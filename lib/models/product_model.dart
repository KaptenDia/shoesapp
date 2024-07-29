// @dart=2.9

import 'package:jogjasport/models/category_model.dart';
import 'package:jogjasport/models/gallery_model.dart';
import 'package:jogjasport/util.dart';

import 'comment_model.dart';

class ProductModel {
  int id;
  String brandName;
  String type;
  int price;
  int stock;
  String description;
  String tags;
  String rating;
  int shippingPrice;
  CategoryModel category;
  DateTime createdAt;
  DateTime updatedAt;
  List<GalleryModel> galleries;
  List<String> colors;
  List<int> sizes;
  List<Comments> comments;

  ProductModel({
    this.id,
    this.brandName,
    this.price,
    this.stock,
    this.shippingPrice,
    this.rating,
    this.description,
    this.tags,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.galleries,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stock = json['stock'];
    brandName = json['brand_name'];
    type = json['type'];
    rating = json['rating'];
    shippingPrice = json['shipping_price'];
    price = int.parse(json['price'].toString());
    description = json['description'];
    tags = json['tags'];
    category = CategoryModel.fromJson(json['category']);

    // Preprocess gallery URLs
    galleries =
        (json['galleries'] as List<dynamic>).map<GalleryModel>((gallery) {
      // Assuming GalleryModel.fromJson handles the URL transformation
      GalleryModel galleryModel = GalleryModel.fromJson(gallery);
      // Update the URL here
      galleryModel.url = galleryModel.url.replaceFirst(
        'http://localhost:8000',
        Util.galleryUrl,
      );
      return galleryModel;
    }).toList();

    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;

    colors = json['colors'].cast<String>();
    sizes = json['sizes'].cast<int>();
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stock': stock,
      'brand_name': brandName,
      'type': type,
      'price': price,
      'shipping_price': shippingPrice,
      'description': description,
      'tags': tags,
      'rating': rating,
      'category': category.toJson(),
      'galleries': galleries.map((gallery) => gallery.toJson()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
      'colors': colors,
      'sizes': sizes,
      'comment': comments.map((e) => e.toJson()).toList(),
    };
  }
}

class UninitializedProductModel extends ProductModel {}
