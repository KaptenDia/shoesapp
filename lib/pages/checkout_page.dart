import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jogjasport/util.dart';
import 'package:provider/provider.dart';
import 'package:jogjasport/providers/auth_provider.dart';
import 'package:jogjasport/providers/cart_provider.dart';
import 'package:jogjasport/providers/transaction_provider.dart';
import 'package:jogjasport/theme.dart';
import 'package:jogjasport/widgets/checkout_card.dart';

import '../image_full_screen.dart';
import '../widgets/loading_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleCheckout() async {
      if (cartProvider.imgProofPath == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: alertColor,
          content: const Text(
            'Mohon Upload Bukti Transfer',
            textAlign: TextAlign.center,
          ),
        ));
        return;
      }
      setState(() {
        isLoading = true;
      });

      if (await transactionProvider.checkout(
          authProvider.user.token,
          cartProvider.carts,
          cartProvider.totalPrice(),
          authProvider.isChanged == true
              ? authProvider.addressController.text
              : authProvider.user.address,
          cartProvider.imgProofName)) {
        cartProvider.carts = [];
        Navigator.restorablePushNamedAndRemoveUntil(
            context, '/checkout-success', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: alertColor,
          content: const Text(
            'Checkout Gagal',
            textAlign: TextAlign.center,
          ),
        ));
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return AppBar(
        backgroundColor: bgColor1,
        leading: GestureDetector(
            onTap: () {
              authProvider.addressController.clear();
              authProvider.isChanged = false;
              cartProvider.imgProofName = null;
              cartProvider.imgProofPath = null;
              setState(() {});
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Detail Checkout',
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          // Note List Item
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Item',
                  style: primarytextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Column(
                  children: cartProvider.carts
                      .map(
                        (cart) => CheckoutCard(cart),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          // NOTE: ADDRESS DETAIL
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: bgColor4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detail Alamat',
                      style: primarytextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Ubah Alamat'),
                              content: TextField(
                                controller: authProvider.addressController,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Simpan'),
                                  onPressed: () {
                                    authProvider.changeAddress(
                                        authProvider.addressController.text);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Ubah Alamat'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/icon_store_location.png',
                          width: 40,
                        ),
                        Image.asset(
                          'assets/line.png',
                          height: 30,
                        ),
                        Image.asset(
                          'assets/icon_your_address.png',
                          width: 40,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lokasi Store',
                          style: secondarytextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          'Adidas Core',
                          style: primarytextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                        SizedBox(
                          height: defaultMargin,
                        ),
                        Text(
                          'Alamat Kamu',
                          style: secondarytextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 300,
                          child: Text(
                            authProvider.isChanged
                                ? authProvider.addressController.text
                                : authProvider.user.address,
                            style: primarytextStyle.copyWith(
                              fontWeight: medium,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // NOTE: PAYMENT SUMMARY
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: bgColor4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Pembayaran',
                  style: primarytextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kuantitas Produk',
                      style: secondarytextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${cartProvider.totalItems()} Produk',
                      style: primarytextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Harga Produk',
                      style: secondarytextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Rp.${cartProvider.totalPrice()}',
                      style: primarytextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xff2E3141),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: pricetextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      'Rp.${cartProvider.totalPrice()}',
                      style: pricetextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: defaultMargin,
          ),

          const _Photo(),

          // NOTE : CHECKOUT BUTTON
          SizedBox(
            height: defaultMargin,
          ),
          const Divider(
            thickness: 1,
            color: Color(0xff2E3141),
          ),
          isLoading
              ? Container(
                  margin: const EdgeInsets.only(
                    bottom: 30,
                  ),
                  child: const LoadingButton(),
                )
              : Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: defaultMargin,
                  ),
                  child: TextButton(
                    onPressed: handleCheckout,
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Checkout',
                      style: primarytextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: header(),
      ),
      body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: content()),
    );
  }
}

class _Photo extends StatefulWidget {
  const _Photo({Key key});

  @override
  State<_Photo> createState() => _PhotoState();
}

class _PhotoState extends State<_Photo> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    void pickPhotoFromCamera() async {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (returnedImage != null) {
        cartProvider.imgProofPath = returnedImage.path;
        cartProvider.imgProofName = returnedImage.name;
      }
      setState(() {});
    }

    void pickPhotoFromGallery() async {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage != null) {
        cartProvider.imgProofPath = returnedImage.path;
        cartProvider.imgProofName = returnedImage.name;
      }
      setState(() {});
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Upload Bukti Pembayaran',
          style: primarytextStyle,
        ),
        const SizedBox(height: 12),
        ExpansionTile(
          expandedAlignment: Alignment.topLeft,
          tilePadding: EdgeInsets.zero,
          title: Text(
            'Info Pembayaran',
            style: secondarytextStyle.copyWith(
              color: primarytextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'E-Wallet :',
                  style: secondarytextStyle.copyWith(
                    color: primarytextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/ic_dana.png',
                          width: 60,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Image.asset(
                          'assets/ic_ovo.png',
                          width: 40,
                        ),
                      ],
                    ),
                    Text(
                      '081341206957',
                      style: secondarytextStyle.copyWith(
                        color: primarytextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  'Bank BNI :',
                  style: secondarytextStyle.copyWith(
                    color: primarytextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/ic_bni.png',
                      width: 60,
                    ),
                    Text(
                      '0246003829',
                      style: secondarytextStyle.copyWith(
                        color: primarytextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Bukti Pembayaran :',
                      style: secondarytextStyle.copyWith(
                        color: primarytextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: bgColor3,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Util().showModalTakePhoto(
                                onSelect: (index) {
                                  if (index == 0) {
                                    pickPhotoFromCamera();
                                  } else {
                                    pickPhotoFromGallery();
                                  }
                                },
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: primaryColor.withOpacity(0.2),
                              ),
                            ),
                            if (cartProvider.imgProofPath != null)
                              GestureDetector(
                                onTap: () {},
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Image.file(
                                      File(cartProvider.imgProofPath ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            if (cartProvider.imgProofPath != null)
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageFullScreen(
                                        path: cartProvider.imgProofPath,
                                      ),
                                    )),
                                child: SizedBox(
                                  height: 114,
                                  width: 114,
                                  child: Center(
                                    child: Text(
                                      'Tap untuk preview',
                                      textAlign: TextAlign.center,
                                      style: secondarytextStyle.copyWith(
                                          color: Colors.white,
                                          shadows: [
                                            const Shadow(
                                              color: Colors.black,
                                              offset: Offset(1, 1),
                                              blurRadius: 4,
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pilih foto upload bukti pembayaran dengan mengambil dari galeri atau langsung dengan kamera',
                                style: secondarytextStyle.copyWith(
                                  height: 1.2,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () => Util().showModalTakePhoto(
                                  onSelect: (index) {
                                    if (index == 0) {
                                      pickPhotoFromCamera();
                                    } else {
                                      pickPhotoFromGallery();
                                    }
                                  },
                                ),
                                child: Text(
                                  cartProvider.imgProofPath != null
                                      ? 'Ambil foto ulang'
                                      : 'Ambil foto',
                                  style: primarytextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
