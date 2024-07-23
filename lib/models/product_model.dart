// @dart=2.9

import 'package:jogjasport/models/category_model.dart';
import 'package:jogjasport/models/gallery_model.dart';

class ProductModel {
  int id;
  String brandId;
  String type;
  int price;
  int stock;
  String description;
  String tags;
  CategoryModel category;
  DateTime createdAt;
  DateTime updatedAt;
  List<GalleryModel> galleries;

  ProductModel({
    this.id,
    this.brandId,
    this.price,
    this.stock,
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
    brandId = json['brand_name'];
    type = json['type'];
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
        'https://298d-114-10-144-211.ngrok-free.app',
      );
      return galleryModel;
    }).toList();

    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stock': stock,
      'brand_name': brandId,
      'type': type,
      'price': price,
      'description': description,
      'tags': tags,
      'category': category.toJson(),
      'galleries': galleries.map((gallery) => gallery.toJson()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}

class UninitializedProductModel extends ProductModel {}
