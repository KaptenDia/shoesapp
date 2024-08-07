import 'package:jogjasport/models/category_model.dart';
import 'package:jogjasport/models/gallery_model.dart';
import 'package:jogjasport/util.dart';

class ProductModel {
  int? id;
  String? brandId;
  String? type;
  int? price;
  int? stock;
  String? description;
  String? tags;
  CategoryModel? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<GalleryModel>? galleries;
  List<ColorData>? colors;
  List<SizeData>? sizes;
  List<Comments>? comments;

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
    this.colors,
    this.sizes,
    this.comments
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
    if (json['colors'] != null) {
      colors = <ColorData>[];
      json['colors'].forEach((v) {
        colors!.add(new ColorData.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = <SizeData>[];
      json['sizes'].forEach((v) {
        sizes!.add(new SizeData.fromJson(v));
      });
    }
    // Preprocess gallery URLs
    galleries =
        (json['galleries'] as List<dynamic>).map<GalleryModel>((gallery) {
      // Assuming GalleryModel.fromJson handles the URL transformation
      GalleryModel galleryModel = GalleryModel.fromJson(gallery);
      // Update the URL here
      galleryModel.url = galleryModel.url?.replaceFirst(
        'http://localhost:8000',
        Util.imageUrl,
      );
      return galleryModel;
    }).toList();

    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
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
      'category': category?.toJson(),
      'galleries': galleries?.map((gallery) => gallery.toJson()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}

class Comments {
  String? customerName;
  String? comment;
  String? rating;

  Comments({this.customerName, this.comment, this.rating});

  Comments.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    comment = json['comment'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customerName;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    return data;
  }
}

class ColorData {
  int? id;
  String? color;

  ColorData({this.id, this.color});

  ColorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color'] = this.color;
    return data;
  }
}

class SizeData {
  int? id;
  int? size;

  SizeData({this.id, this.size});

  SizeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    return data;
  }
}

class UninitializedProductModel extends ProductModel {}
