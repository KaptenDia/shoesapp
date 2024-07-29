import 'package:flutter/widgets.dart';
import 'package:jogjasport/services/comment_service.dart';

import '../models/comment_model.dart';

class CommentProvider with ChangeNotifier {
  final List<Comments> _comments = [];
  List<Comments> get comments => _comments;

  Future<bool> addComment(
    String id,
    String token,
    String message,
    String productId,
    double rating,
  ) async {
    try {
      if (await CommentService().addComment(
          id: id,
          token: token,
          message: message,
          productId: productId,
          rating: rating)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }
}
