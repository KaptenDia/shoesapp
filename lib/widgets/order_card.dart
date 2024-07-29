import 'package:flutter/material.dart';
import 'package:jogjasport/providers/comment_provider.dart';
import 'package:provider/provider.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import '../providers/auth_provider.dart';
import '../theme.dart';

class OrderCard extends StatelessWidget {
  String idTransaction;
  String status;
  String totalPrice;
  OrderCard({
    Key key,
    this.idTransaction,
    this.status,
    this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommentProvider commentProvider = Provider.of<CommentProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleComments() async {
      if (await commentProvider.addComment(
        '65',
        authProvider.user.token,
        'test hehe',
        '65',
        5.0,
      )) {
        Navigator.pop(context);
      }
    }

    void _showReviewDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          double rating = 0;
          TextEditingController reviewController = TextEditingController();

          return AlertDialog(
            title: const Text('Beri Ulasan'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingStars(
                  rating: rating,
                  editable: true,
                ),
                TextField(
                  controller: reviewController,
                  decoration: const InputDecoration(
                    labelText: 'Komentar',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => handleComments(),
                child: const Text('Kirim'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Batal'),
              ),
            ],
          );
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffECEDEF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            child: Text(
              'ID Transaksi : $idTransaction' ?? '-',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: blacktextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.price_change_rounded,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(totalPrice ?? '-'),
                  ],
                ),
              ),
              const SizedBox(
                width: 4.0,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.payment_rounded,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(status ?? '-'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          if (status == "SUKSES")
            TextButton(
              onPressed: () => _showReviewDialog(context),
              child: Row(
                children: const [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text("Beri Ulasan"),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
