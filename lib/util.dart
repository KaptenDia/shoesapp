import 'package:flutter/material.dart';

import 'list_modal.dart';

class Util {
  static String baseUrl = 'https://bacf-114-10-147-161.ngrok-free.app/api';
  static String galleryUrl = 'https://bacf-114-10-147-161.ngrok-free.app';
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static get currentContext {
    return navigatorKey.currentState?.context;
  }

  void showModalTakePhoto({
    String title,
    List<String> options,
    List<IconData> icons,
    Function(int) onSelect,
  }) async {
    showModalBottom(
      content: ListModal(
        title: title ?? "Pilih Gambar Dari",
        list: options ??
            [
              'Kamera',
              'Galeri',
            ],
        listIcon: icons ??
            const [
              Icons.camera_alt_rounded,
              Icons.photo_size_select_actual_rounded,
            ],
        onSelect: onSelect ?? (int index) {},
      ),
    );
  }

  Future<void> showModalBottom({
    bool isDismissible = true,
    bool keyboardPush = false,
    Widget content,
    Function() onComplete,
  }) async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: currentContext,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) => keyboardPush
          ? Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: content,
            )
          : content,
    ).whenComplete(() async {
      await Future.delayed(const Duration(milliseconds: 400));
      onComplete?.call();
    });
  }
}
