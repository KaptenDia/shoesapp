import 'package:flutter/material.dart';
import 'package:jogjasport/theme.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

import '../models/comment_model.dart';

class ReviewPage extends StatelessWidget {
  final List<Comments> comments;
  final String title;
  const ReviewPage({Key key, this.comments, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed via Navigator
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic> ??
            {};

    // Extract the comments and title from the arguments
    final List<Comments> comments = args['comments'] ?? [];
    final String title = args['title'] ?? 'Review Page';

    return Scaffold(
      backgroundColor: bgColor1,
      appBar: AppBar(
        backgroundColor: bgColor1,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Ulasan $title',
          style: primarytextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
      body: comments.isEmpty
          ? Center(
              child: Text(
              'Belum ada ulasan',
              style: primarytextStyle,
            ))
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return _ReviewCard(
                  comments: comments[index],
                );
              },
            ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Comments comments;
  const _ReviewCard({Key key, this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(
          comments?.customerName ?? '-',
          style: primarytextStyle.copyWith(
            fontSize: 14,
            fontWeight: bold,
            color: primaryColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 12.0),
            RatingStars(
              rating: double.parse(comments?.rating ?? '0.0'),
              editable: false,
            ),
            const SizedBox(height: 8.0),
            Text(
              comments?.comment ?? '-',
              style: primarytextStyle.copyWith(
                color: blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
