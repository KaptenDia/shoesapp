import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jogjasport/providers/product_provider.dart';
import 'package:jogjasport/theme.dart';
import 'package:jogjasport/widgets/product_card.dart';
import 'package:jogjasport/widgets/product_categories.dart';
import 'package:jogjasport/widgets/product_tile.dart';

import '../../models/user_models.dart';
import '../../providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hallo, ${user.name}',
                    style: primarytextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@${user.username}',
                    style: subtitletextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    '${user.profilePhotoUrl}&size=512',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget categories() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: defaultMargin),
            Row(
              children: productProvider.categories
                  .map(
                    (categories) => ProductCategories(
                      title: categories.name,
                      isSelected: categories.name == selectedCategory,
                      onTap: () {
                        setState(() {
                          selectedCategory = categories.name;
                        });
                        productProvider.getProductsByCategory(categories.name);
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    }

    Widget popularProductsTitle() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Text(
          'Produk Populer',
          style: primarytextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget popularProducts() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: selectedCategory != null
                  ? productProvider.filteredProducts
                      .map(
                        (product) => ProductCard(product),
                      )
                      .toList()
                  : productProvider.products
                      .map(
                        (product) => ProductCard(product),
                      )
                      .toList()),
        ),
      );
    }

    Widget newArrivalsTitle() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Text(
          'Produk Terbaru',
          style: primarytextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget newArrivals() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
            children: selectedCategory != null
                ? productProvider.filteredProducts
                    .map(
                      (product) => ProductTile(product),
                    )
                    .toList()
                : productProvider.products
                    .map(
                      (product) => ProductTile(product),
                    )
                    .toList()),
      );
    }

    return ListView(
      children: [
        header(),
        const SizedBox(height: 12.0),
        Center(
          child: Text(
            'Data masih kosong',
            style: primarytextStyle,
          ),
        ),
        if (productProvider.filteredProducts.isNotEmpty ||
            productProvider.products.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              categories(),
              popularProductsTitle(),
              popularProducts(),
              newArrivalsTitle(),
              newArrivals(),
            ],
          ),
      ],
    );
  }
}
