// @dart=2.9
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jogjasport/models/category_model.dart';
import 'package:jogjasport/models/product_model.dart';
import 'package:jogjasport/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<CategoryModel> _categories = [];
  List<ProductModel> get products => _products;
  List<CategoryModel> get categories => _categories;
  List<ProductModel> filteredProducts = [];

  set categories(List<CategoryModel> categories) {
    _categories = categories;
    notifyListeners(); // Notify listeners here
  }

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners(); // Notify listeners here
  }

  Future<void> getCategories() async {
    try {
      List<CategoryModel> categories = await ProductService().getCategories();
      _categories = categories;
      notifyListeners(); // Notify listeners after updating categories
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  List<ProductModel> getProductsByCategory(String category) {
    filteredProducts = _products
        .where((product) => product.category.name == category)
        .toList();
    notifyListeners();
    return filteredProducts;
  }
}
