import 'package:flutter/material.dart';

class SPSolidButton extends StatelessWidget {
  const SPSolidButton({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(Appcolor.buttonColor),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: Text(text),
      ),
    );
  }
}

