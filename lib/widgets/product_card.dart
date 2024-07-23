import 'package:flutter/material.dart';
import 'package:jogjasport/theme.dart';

import '../models/product_model.dart';
import '../pages/home/product_page.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        width: 215,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffECEDEF),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            if (product.galleries.isNotEmpty)
              Image.network(
                product.galleries[0].url,
                width: 215,
                height: 150,
                fit: BoxFit.cover,
              ),
            if (product.galleries.isEmpty)
              Image.network(
                'https://via.placeholder.com/220x150',
              ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.name,
                    style: secondarytextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '${product.brandId} ${product.type} adsfasdfasdf',
                    style: blacktextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Rp.${product.price}',
                    style: pricetextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
