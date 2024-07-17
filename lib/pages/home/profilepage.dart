import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jogjasport/models/user_models.dart';
import 'package:jogjasport/providers/auth_provider.dart';
import 'package:jogjasport/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    Widget header(BuildContext context) {
      return AppBar(
        backgroundColor: bgColor1,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
              padding: EdgeInsets.all(
                defaultMargin,
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      '${user.profilePhotoUrl}&size=512',
                      width: 64,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/sign-in', (route) => false);
                    },
                    child: Image.asset(
                      'assets/button_exit.png',
                      width: 20,
                    ),
                  ),
                ],
              )),
        ),
      );
    }

    Widget menuItem(String text) {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: secondarytextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            Icon(Icons.chevron_right, color: primarytextColor),
          ],
        ),
      );
    }

    Widget content(BuildContext context) {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          decoration: BoxDecoration(
            color: bgColor3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Pengaturan Akun',
                style: primarytextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/edit-profile');
                },
                child: menuItem(
                  'Edit Profil',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/order-page');
                },
                child: menuItem(
                  'Orderan Kamu',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(context),
        content(context),
      ],
    );
  }
}
