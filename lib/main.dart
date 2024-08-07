import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jogjasport/pages/order_page.dart';
import 'package:jogjasport/util.dart';
import 'package:provider/provider.dart';
import 'package:jogjasport/pages/cart_page.dart';
import 'package:jogjasport/pages/checkout_page.dart';
import 'package:jogjasport/pages/checkout_success_page.dart';
import 'package:jogjasport/pages/home/edit_profile_page.dart';
import 'package:jogjasport/pages/home/mainpage.dart';
import 'package:jogjasport/pages/sign_in_page.dart';
import 'package:jogjasport/pages/sign_up_page.dart';
import 'package:jogjasport/pages/splashpage.dart';
import 'package:jogjasport/providers/auth_provider.dart';
import 'package:jogjasport/providers/cart_provider.dart';
import 'package:jogjasport/providers/page_provider.dart';
import 'package:jogjasport/providers/product_provider.dart';
import 'package:jogjasport/providers/transaction_provider.dart';
import 'package:jogjasport/providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        )
      ],
      child: MaterialApp(
        navigatorKey: Util.navigatorKey,
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/home': (context) => const MainPage(),
          '/edit-profile': (context) => const EditProfilePage(),
          '/cart': (context) => const CartPage(),
          '/checkout': (context) => const CheckoutPage(),
          '/checkout-success': (context) => const CheckoutSuccessPage(),
          '/order-page': (context) => const OrderPage(),
        },
      ),
    );
  }
}
