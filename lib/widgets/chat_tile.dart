import 'package:flutter/material.dart';
import 'package:jogjasport/models/message_model.dart';
import 'package:jogjasport/models/product_model.dart';
import 'package:jogjasport/pages/home/detail_chat_page.dart';
import 'package:jogjasport/theme.dart';

class ChatTile extends StatelessWidget {
  const ChatTile(this.message, {Key? key}) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailChatPage(
              UninitializedProductModel(),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 33,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/image_shop_logo.png',
                  width: 54,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jaya Sport',
                        style: primarytextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        message.message!,
                        style: secondarytextStyle.copyWith(
                          fontWeight: light,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Now',
                  style: secondarytextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const Divider(
              thickness: 1,
              color: Color(0xff2B2939),
            ),
          ],
        ),
      ),
    );
  }
}
