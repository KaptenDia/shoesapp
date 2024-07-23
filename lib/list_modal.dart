import 'package:flutter/material.dart';
import 'package:jogjasport/container_bottom.dart';
import 'package:jogjasport/theme.dart';

class ListModal extends StatelessWidget {
  const ListModal({
    Key key,
    this.title,
    this.list,
    this.onSelect,
    this.listIcon,
    this.scrollable = false,
  }) : super(key: key);

  final String title;
  final bool scrollable;
  final List<String> list;
  final List<IconData> listIcon;
  final Function(int) onSelect;

  Widget item(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onSelect(index);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.transparent,
                  width: 0.5,
                ),
              )),
          child: Row(
            children: [
              if (listIcon[index] != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    listIcon[index],
                    color: primaryColor,
                  ),
                ),
              Expanded(
                child: Text(list[index],
                    style: secondarytextStyle.copyWith(
                        fontWeight: FontWeight.w500)),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBottomSheet(
      padding: EdgeInsets.zero,
      showCloseButton: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Row(
              children: [
                Text(
                  title,
                  style: secondarytextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: SizedBox(
              height: list.length > 5
                  ? MediaQuery.of(context).size.height * 0.4
                  : null,
              child: ListView.builder(
                shrinkWrap: true,
                physics: scrollable == true
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: list.length,
                itemBuilder: (context, index) => item(context, index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
