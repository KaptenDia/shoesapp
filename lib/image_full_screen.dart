import 'dart:io';

import 'package:flutter/material.dart';

class ImageFullScreen extends StatelessWidget {
  final String path;
  final String url;
  const ImageFullScreen({
    Key key,
    this.path,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            getImageWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 24),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.4),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  highlightColor: Colors.white.withOpacity(0.1),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImageWidget() {
    if (path != null) {
      return Center(
        child: Image.file(
          File(path),
          alignment: Alignment.center,
        ),
      );
    } else if (url != null) {
      return Center(
        child: Image.network(url),
      );
    } else {
      return const SizedBox();
    }
  }
}
