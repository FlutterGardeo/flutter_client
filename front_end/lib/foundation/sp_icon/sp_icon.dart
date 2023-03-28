import 'package:flutter/material.dart';

class SPIcon extends StatelessWidget {
  const SPIcon(
      {Key? key,
      required this.assetname,
        this.isSelected=false,
      required this.index,
      })
      : super(key: key);
  final String assetname;
  final int? index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/$assetname",
      height: 25,
      width: 25,
      color: index == isSelected ? const Color(0xfffe416c) : Colors.black,
    );
  }
}
