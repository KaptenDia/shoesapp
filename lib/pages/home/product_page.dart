import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jogjasport/models/product_model.dart';
import 'package:jogjasport/providers/cart_provider.dart';
import 'package:jogjasport/providers/wishlist_provider.dart';
import 'package:jogjasport/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;
  const ProductPage(this.product, {Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int currentIndex = 0;
  int? colorsVariant;
  int? sizeVariant;
  double sumRating = 0;
  double totalRating = 0;

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
  void initState() {
    super.initState();
    widget.product.comments!.forEach((element) {
      sumRating = sumRating + (element.rating != null ? (double.tryParse(element.rating ?? "0"))!.toInt() : 0);
    },);
    totalRating = sumRating / (widget.product.comments?.length ?? 0);
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

    // Widget familiarShoesCard(String imageUrl) {
    //   return Container(
    //     width: 54,
    //     height: 54,
    //     margin: const EdgeInsets.only(
    //       right: 16,
    //     ),
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage(imageUrl),
    //       ),
    //       borderRadius: BorderRadius.circular(6),
    //     ),
    //   );
    // }

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
              ],
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          CarouselSlider(
            items: widget.product.galleries!.isNotEmpty
                ? widget.product.galleries?.map(
                      (image) => Image.network(
                        image.url!,
                        width: MediaQuery.of(context).size.width,
                        height: 310,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList()
                : [
                    Image.network(
                      "https://via.placeholder.com/200x200",
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
            children: widget.product.galleries!.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          ),
        ],
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
                          widget.product.brandId!,
                          style: primarytextStyle.copyWith(
                            fontSize: 32,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          widget.product.category!.name!,
                          style: secondarytextStyle.copyWith(
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: List.generate(
                            5,
                                (indexs) {
                              return Icon(
                                indexs < totalRating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                              );
                            },
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

            SizedBox(height: 20,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                children: [
                  Text(
                    "Warna :",
                    style: subtitletextStyle.copyWith(
                        fontWeight: light,
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      child: ListView.separated(
                        itemCount: widget.product.colors!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(width: 10,),
                        itemBuilder: (context, index) {
                          return Text(
                            "${ widget.product.colors![index].color}",
                            style: subtitletextStyle.copyWith(
                                fontWeight: light,
                                fontSize: 16,
                                color: Colors.white
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 12,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                children: [
                  Text(
                    "Ukuran :",
                    style: subtitletextStyle.copyWith(
                        fontWeight: light,
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      child: ListView.separated(
                        itemCount: widget.product.sizes!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(width: 10,),
                        itemBuilder: (context, index) {
                          return Text(
                            "${ widget.product.sizes![index].size}",
                            style: subtitletextStyle.copyWith(
                                fontWeight: light,
                                fontSize: 16,
                                color: Colors.white
                            ),
                          );
                        },
                      ),
                    ),
                  )
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
                    'Deskripsi Produk',
                    style: primarytextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.product.description!,
                    style: subtitletextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 16,
                      color: Colors.white
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Ulasan : ',
                    style: primarytextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.separated(
                    itemCount: widget.product.comments!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(height: 16,),
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.product.comments![index].customerName}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: List.generate(
                                5,
                                    (indexs) {
                                  return Icon(
                                    indexs < double.tryParse(widget.product.comments![index].rating ?? "0")!.toInt() ? Icons.star : Icons.star_border,
                                    color: Colors.amber,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "${widget.product.comments![index].comment}",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
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
                      'Hai apakah ${widget.product.brandId} masih ada?',
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
                        onPressed: (widget.product.stock ?? 0) > 0
                            ? () {
                                if(widget.product.colors!.isNotEmpty || widget.product.sizes!.isNotEmpty) {
                                  sizeVariant = null;
                                  colorsVariant = null;
                                  showModalBottomSheet(
                                      context: context,
                                      enableDrag: true,
                                      isScrollControlled: true,
                                      builder: (builder){
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Container(
                                                width: double.infinity,
                                                color: Colors.transparent,
                                                child: new Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(20),
                                                    decoration: new BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: new BorderRadius.only(
                                                            topLeft: const Radius.circular(10.0),
                                                            topRight: const Radius.circular(10.0))),
                                                    child: StatefulBuilder(
                                                        builder: (context, setState) {
                                                          return Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Text("Pilih Varian", style: TextStyle(fontWeight: FontWeight.bold),),
                                                                SizedBox(height: 20,),
                                                                Text("Warna"),
                                                                SizedBox(height: 10,),
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 40,
                                                                  child: ListView.separated(
                                                                    itemCount: widget.product.colors!.length,
                                                                    shrinkWrap: true,
                                                                    scrollDirection: Axis.horizontal,
                                                                    separatorBuilder: (context, index) => SizedBox(width: 10,),
                                                                    itemBuilder: (context, index) {
                                                                      return GestureDetector(
                                                                        onTap: () {
                                                                          setState(() {
                                                                            colorsVariant = widget.product.colors![index].id;
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                          padding: EdgeInsets.all(10),
                                                                          decoration: BoxDecoration(
                                                                            color: colorsVariant == widget.product.colors![index].id ?  Colors.deepPurpleAccent : Colors.white,
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            border: Border.all(width: 1, color: colorsVariant == widget.product.colors![index].id ?  Colors.deepPurpleAccent : Colors.grey)
                                                                          ),
                                                                          child: Text(
                                                                            "${widget.product.colors![index].color}",
                                                                            style: subtitletextStyle.copyWith(
                                                                                fontSize: 16,
                                                                                color: colorsVariant == widget.product.colors![index].id ?  Colors.white : Colors.grey
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(height: 20,),
                                                                Text("Ukuran"),
                                                                SizedBox(height: 10,),
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 40,
                                                                  child: ListView.separated(
                                                                    itemCount: widget.product.sizes!.length,
                                                                    shrinkWrap: true,
                                                                    scrollDirection: Axis.horizontal,
                                                                    separatorBuilder: (context, index) => SizedBox(width: 10,),
                                                                    itemBuilder: (context, index) {
                                                                      return GestureDetector(
                                                                        onTap: () {
                                                                          setState(() {
                                                                            sizeVariant = widget.product.sizes![index].id;
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                          padding: EdgeInsets.all(10),
                                                                          decoration: BoxDecoration(
                                                                            color: sizeVariant == widget.product.sizes![index].id ?  Colors.deepPurpleAccent : Colors.white,
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            border: Border.all(width: 1, color: sizeVariant == widget.product.sizes![index].id ?  Colors.deepPurpleAccent : Colors.grey)
                                                                          ),
                                                                          child: Text(
                                                                            "${widget.product.sizes![index].size}",
                                                                            style: subtitletextStyle.copyWith(
                                                                                fontSize: 16,
                                                                                color: sizeVariant == widget.product.sizes![index].id ?  Colors.white : Colors.grey
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(height: 20,),
                                                                SizedBox(
                                                                  width: double.infinity,
                                                                  child: ElevatedButton(
                                                                    onPressed: () async {
                                                                      if(colorsVariant == null || sizeVariant == null) {
                                                                        Navigator.pop(context);
                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                          SnackBar(
                                                                            backgroundColor: alertColor,
                                                                            content: const Text(
                                                                              'Mohon Lengkapi Data',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        cartProvider.addCart(widget.product, colorsVariant ?? 0, sizeVariant ?? 0);
                                                                        showSuccessDialog();
                                                                      }
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor: Colors.deepPurpleAccent,
                                                                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      "Masukan Keranjang",
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ]
                                                          );
                                                        }
                                                    )
                                                )
                                            ),
                                          ),
                                        );
                                      }
                                  );
                                } else {
                                  cartProvider.addCart(widget.product, 0, 0);
                                  showSuccessDialog();
                                }
                              }
                            : null,
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: (widget.product.stock ?? 0) > 0
                              ? primaryColor
                              : Colors.grey,
                        ),
                        child: Text(
                          'Tambahkan Ke Keranjang',
                          style: primarytextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                            color: (widget.product.stock ?? 0) > 0
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
