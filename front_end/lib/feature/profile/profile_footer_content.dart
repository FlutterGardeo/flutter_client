import 'package:flutter/material.dart';
import 'package:front_end/foundation/sp_text_button/sp_text_button.dart';

class FooterContent extends StatelessWidget {
  const FooterContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SPTextButton(text: "FAQs"),
        SPTextButton(text: "ABOUT Us"),
        SPTextButton(text: "TERMS OF USE"),
        SPTextButton(text: "PRIVACY POLICY"),
      ],
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Widget')),
      body: const FooterContent(),
    );
  }
}
