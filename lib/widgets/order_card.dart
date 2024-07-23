import 'package:flutter/material.dart';

import '../theme.dart';

class OrderCard extends StatelessWidget {
  String imgUrl;
  String itemName;
  String idTransaction;
  String status;
  String totalPrice;
  OrderCard({
    Key key,
    this.imgUrl,
    this.itemName,
    this.idTransaction,
    this.status,
    this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffECEDEF),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imgUrl ?? "https://via.placeholder.com/215x150",
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 300,
                child: Text(
                  itemName ?? 'Nama Item',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: blacktextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                'Id Transaksi # ${idTransaction ?? '-'}',
                style: pricetextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
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
            ],
          ),
        ],
      ),
    );
  }
}
