import 'dart:convert';
import 'package:http/http.dart' as http;
import '../util.dart';

class CommentService {
  Future<bool> addComment({
    String id,
    String token,
    String message,
    String productId,
    double rating,
  }) async {
    var url = '${Util.baseUrl}/comment/{65}';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'comment': message,
      'product_id': productId,
      'id': id,
      'rating': rating,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to Comments!');
    }
  }
}
