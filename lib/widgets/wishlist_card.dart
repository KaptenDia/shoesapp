import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jogjasport/models/product_model.dart';
import 'package:jogjasport/providers/wishlist_provider.dart';
import 'package:jogjasport/theme.dart';

import '../pages/home/product_page.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard(this.product, {Key key}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        padding: const EdgeInsets.only(
          top: 10,
          left: 12,
          bottom: 14,
          right: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor4,
        ),
        child: Row(
          children: [
            if (product.galleries.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.galleries[0].url,
                  width: 60,
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
                    product.brandId,
                    style: primarytextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '\$${product.price}',
                    style: pricetextStyle,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                wishlistProvider.setProduct(product);
              },
              child: Image.asset(
                'assets/button_wishlist_blue.png',
                width: 34,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
