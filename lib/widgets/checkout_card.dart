import 'package:flutter/material.dart';
import 'package:jogjasport/theme.dart';

import '../models/cart_model.dart';

class CheckoutCard extends StatelessWidget {
  final CartModel cart;
  final String size;
  final String color;
  const CheckoutCard(this.cart, {Key key, this.size, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 12,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: bgColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cart.product.galleries.isNotEmpty
              ? Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        cart.product.galleries[0].url,
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/placeholder_newest.png',
                      ),
                    ),
                  ),
                ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${cart.product.brandName} ${cart.product.type}',
                  style: primarytextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  'Rp.${cart.product.price}',
                  style: pricetextStyle,
                ),
                Text(
                  'Biaya Pengiriman : Rp.${cart.product.shippingPrice ?? 0}',
                  style: pricetextStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$size, ',
                        style: primarytextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        color,
                        style: primarytextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            '${cart.quantity} Items',
            style: secondarytextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
