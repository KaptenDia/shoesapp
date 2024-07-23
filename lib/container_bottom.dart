import 'package:flutter/material.dart';
import 'package:jogjasport/theme.dart';

class ContainerBottomSheet extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool showCloseButton;
  final Function() actionDismiss;

  const ContainerBottomSheet({
    Key key,
    this.child,
    this.padding = const EdgeInsets.fromLTRB(16, 24, 16, 16),
    this.showCloseButton = false,
    this.actionDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.transparent,
      color: Colors.transparent.withOpacity(0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showCloseButton)
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.fromLTRB(0, 24, 24, 16),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    actionDismiss?.call();
                  },
                  highlightColor: Colors.white.withOpacity(0.1),
                  icon: Icon(
                    Icons.close,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          Container(
            padding: padding,
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
