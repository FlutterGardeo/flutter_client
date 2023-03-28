import 'package:flutter/material.dart';
import 'package:front_end/foundation/sp_text_button/sp_text_button.dart';
import 'package:front_end/foundation/theme/colors.dart';

class FooterContent extends StatelessWidget {
  const FooterContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
          child: FooterText(text: "Footer content"),
        ),
      ),
    );
  }
}

class FooterText extends StatelessWidget {
  final String text;

  const FooterText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: AppColor.heading6,
      ),
    );
  }
}
