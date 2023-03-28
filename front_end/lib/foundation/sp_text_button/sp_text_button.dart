import 'package:flutter/material.dart';

class SPTextButton extends StatelessWidget {
  const SPTextButton({Key? key,required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {

    return Material (
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 60),
          width: MediaQuery.of(context).size.width,
          child: Text(text, style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Colors.black),
          ),
        ),
      ),
    );
  }
}
