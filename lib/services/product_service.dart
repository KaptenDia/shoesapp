import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:jogjasport/models/category_model.dart';
import 'package:jogjasport/models/product_model.dart';
import 'package:jogjasport/util.dart';

class ProductService {
  // ignore: missing_return
  Future<List<ProductModel>> getProducts() async {
    var url = '${Util.baseUrl}/products';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    // ignore: avoid_print
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      // ignore: avoid_print
      print('Gagal Get Products!');
      return [];
    }
  }

  // ignore: missing_return
  Future<List<CategoryModel>> getCategories() async {
    var url = '${Util.baseUrl}/categories';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    // ignore: avoid_print
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<CategoryModel> categories = [];

      for (var item in data) {
        categories.add(CategoryModel.fromJson(item));
      }
      log(categories.toString());
      return categories;
    } else {
      // ignore: avoid_print
      print('Gagal Get Products!');
      return [];
    }
  }
}
