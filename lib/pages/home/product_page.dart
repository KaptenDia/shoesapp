import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jogjasport/models/product_model.dart';
import 'package:jogjasport/providers/cart_provider.dart';
import 'package:jogjasport/providers/wishlist_provider.dart';
import 'package:jogjasport/theme.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;
  const ProductPage(this.product, {Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int currentIndex = 0;
  String _selectedColor;
  int _selectedSizes;

  @override
  void initState() {
    super.initState();
    // Initialize the selected color with the first color in the list, if available
    if (widget.product.colors.isNotEmpty) {
      _selectedColor = null;
    }
    // Initialize the selected size with the first size in the list, if available
    if (widget.product.sizes.isNotEmpty) {
      _selectedSizes = null;
    }
  }

  Future<void> launchWhatsappWithMobileNumber(String message) async {
    final url = "whatsapp://send?phone=6281341206957&text=$message";
    if (await canLaunchUrl(Uri.parse(Uri.encodeFull(url)))) {
      await launchUrl(Uri.parse(Uri.encodeFull(url)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: alertColor,
          content: const Text(
            'Gagal membuka whatsapp',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => SizedBox(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: bgColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: primarytextColor,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/icon_success.png',
                    width: 100,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Hore :)',
                    style: primarytextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Item telah ditambahkan kedalam keranjang',
                    style: secondarytextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 154,
                    height: 44,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Lihat Keranjang',
                        style: primarytextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 48 : 28,
        height: 8,
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? primaryColor : const Color(0xffC4C4C4),
        ),
      );
    }

    Widget header() {
      int index = -1;

      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.chevron_left,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Detail Produk',
                  style: primarytextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          CarouselSlider(
            items: widget.product.galleries.isNotEmpty
                ? widget.product.galleries
                    .map(
                      (image) => Image.network(
                        image.url,
                        width: MediaQuery.of(context).size.width,
                        height: 310,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList()
                : [
                    Image.asset(
                      "assets/placeholder_detail.png",
                      width: double.infinity,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ],
            options: CarouselOptions(
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.galleries.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          ),
        ],
      );
    }

    Widget colorSelection() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Warna',
              style: primarytextStyle.copyWith(
                fontWeight: bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Wrap(
              spacing: 8,
              children: widget.product.colors.map((color) {
                return ChoiceChip(
                  label: Text(
                    color,
                    style: primarytextStyle.copyWith(
                      color:
                          _selectedColor == color ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: _selectedColor == color,
                  selectedColor: primaryColor,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedColor = selected ? color : null;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      );
    }

    Widget sizeSelection() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Ukuran',
              style: primarytextStyle.copyWith(
                fontWeight: bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Wrap(
              spacing: 8,
              children: widget.product.sizes.map((sizes) {
                return ChoiceChip(
                  label: Text(
                    sizes.toString(),
                    style: primarytextStyle.copyWith(
                      color:
                          _selectedSizes == sizes ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: _selectedSizes == sizes,
                  selectedColor: primaryColor,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedSizes = selected ? sizes : null;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 17),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: bgColor1,
        ),
        child: Column(
          children: [
            // NOTE: HEADER
            Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.product.brandName} ${widget.product.type}',
                          style: primarytextStyle.copyWith(
                            fontSize: 32,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          widget.product.category.name,
                          style: secondarytextStyle.copyWith(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          wishlistProvider.setProduct(widget.product);

                          if (wishlistProvider.isWishlist(widget.product)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: secondaryColor,
                                content: const Text(
                                  'Telah ditambahkan ke WishList',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: alertColor,
                                content: const Text(
                                  'Telah dihapus dari WishList',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        },
                        child: Image.asset(
                          wishlistProvider.isWishlist(widget.product)
                              ? 'assets/button_wishlist_blue.png'
                              : 'assets/button_wishlist.png',
                          width: 46,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        'Stok : ${widget.product.stock.toString()}',
                        style: primarytextStyle.copyWith(
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // NOTE: PRICE
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 20,
                left: defaultMargin,
                right: defaultMargin,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor2,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Harga',
                    style: primarytextStyle.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    'Rp.${widget.product.price}',
                    style: pricetextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),

            // NOTE: RATING
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RatingStars(
                        rating: double.parse(widget.product.rating),
                        editable: false,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        widget.product.rating,
                        style: primarytextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/review-page',
                      arguments: {
                        'comments': widget.product.comments,
                        'title':
                            '${widget.product.brandName} ${widget.product.type}',
                      },
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.reviews,
                          color: primaryColor,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          'Lihat semua ulasan',
                          style: primarytextStyle.copyWith(
                            fontWeight: medium,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // NOTE: DESCRIPTION
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dekripsi Produk',
                    style: primarytextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.product.description,
                    style: subtitletextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            if (widget.product.stock > 0)
              // NOTE: COLOR SELECTION
              colorSelection(),
            const SizedBox(
              height: 8.0,
            ),
            // NOTE: SIZE SELECTION
            if (widget.product.stock > 0) sizeSelection(),
            const SizedBox(
              height: 32.0,
            ),
            // NOTE: BUTTONS
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(defaultMargin),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async => await launchWhatsappWithMobileNumber(
                      'Hai apakah ${widget.product.brandName} ${widget.product.type} masih ada?',
                    ),
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/button_chat.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: TextButton(
                        onPressed: widget.product.stock > 0
                            ? () {
                                if (_selectedColor == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: alertColor,
                                      content: const Text(
                                        'Pilih warna terlebih dahulu!',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                } else if (_selectedSizes == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: alertColor,
                                      content: const Text(
                                        'Pilih ukuran terlebih dahulu!',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                } else {
                                  cartProvider.addCart(
                                    widget.product,
                                    _selectedSizes,
                                    _selectedColor,
                                  );
                                  showSuccessDialog();
                                }
                              }
                            : null,
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: widget.product.stock > 0
                              ? primaryColor
                              : Colors.grey,
                        ),
                        child: Text(
                          'Tambahkan Ke Keranjang',
                          style: primarytextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                            color: widget.product.stock > 0
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor1,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
