import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jogjasport/models/message_model.dart';
import 'package:jogjasport/providers/auth_provider.dart';
import 'package:jogjasport/providers/page_provider.dart';
import 'package:jogjasport/services/message_service.dart';
import 'package:jogjasport/theme.dart';
import 'package:jogjasport/widgets/chat_tile.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Future<void> launchWhatsappWithMobileNumber(String message) async {
      final url =
          "whatsapp://send?phone=6281341206957&text=${Uri.encodeComponent(message)}";
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Gagal membuka WhatsApp',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    Widget header() {
      return AppBar(
        backgroundColor: bgColor1,
        centerTitle: true,
        title: Text(
          'Chat Admin Store',
          style: primarytextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    // ignore: unused_element
    Widget emptyChat() {
      return Expanded(
        child: Container(
          width: double.infinity,
          color: bgColor3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/headset_icon.png',
                width: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Chat admin via Whatsapp',
                style: primarytextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Chat untuk dapatkan info tentang product!',
                style: secondarytextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: 44,
                child: TextButton(
                  onPressed: () => launchWhatsappWithMobileNumber(
                    'Hello, saya ingin menanyakan product dari JogjaSport.',
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Chat Whatsapp',
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
      );
    }

    Widget content() {
      return StreamBuilder<List<MessageModel>>(
          stream: MessageService()
              .getMessagesByUserId(userId: authProvider.user.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return emptyChat();
              }

              return Expanded(
                child: Container(
                  width: double.infinity,
                  color: bgColor3,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultMargin,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      ChatTile(snapshot.data[snapshot.data.length - 1]),
                    ],
                  ),
                ),
              );
            } else {
              return emptyChat();
            }
          });
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
