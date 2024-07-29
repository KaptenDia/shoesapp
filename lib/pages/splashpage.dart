import 'package:flutter/material.dart';
import 'package:jogjasport/theme.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();

    super.initState();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    await Provider.of<ProductProvider>(context, listen: false).getCategories();
    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor1,
        body: const Center(
          child: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(
              'assets/logo-jogja-sport.png',
            ),
          ),
        ));
  }
}
