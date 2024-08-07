// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jogjasport/pages/home/chatpage.dart';
import 'package:jogjasport/pages/home/homepage.dart';
import 'package:jogjasport/pages/home/profilepage.dart';
import 'package:jogjasport/pages/home/wishlistpage.dart';
import 'package:jogjasport/theme.dart';

import '../../providers/page_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget cartButoon() {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        backgroundColor: secondaryColor,
        child: Image.asset(
          'assets/icon_cart.png',
          width: 20,
        ),
      );
    }

    Widget customBottomNav() {
      return Container(
        height: 110,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 12,
            clipBehavior: Clip.antiAlias,
            child: BottomNavigationBar(
              backgroundColor: bgColor4,
              currentIndex: pageProvider.currentIndex,
              onTap: (value) {
                pageProvider.currentIndex = value;
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/icon_home.png',
                      width: 21,
                      color: pageProvider.currentIndex == 0
                          ? primaryColor
                          : thirdColor,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/icon_chat.png',
                      width: 20,
                      color: pageProvider.currentIndex == 1
                          ? primaryColor
                          : thirdColor,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/icon_wishlist.png',
                      width: 21,
                      color: pageProvider.currentIndex == 2
                          ? primaryColor
                          : thirdColor,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/icon_profile.png',
                      width: 18,
                      color: pageProvider.currentIndex == 3
                          ? primaryColor
                          : thirdColor,
                    ),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return const HomePage();
          break;
        case 1:
          return const ChatPage();
          break;
        case 2:
          return WishList();
          break;
        case 3:
          return ProfilePage();
          break;
        default:
          return const HomePage();
      }
    }

    return Scaffold(
      backgroundColor: pageProvider.currentIndex == 0 ? bgColor1 : bgColor3,
      floatingActionButton: cartButoon(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
