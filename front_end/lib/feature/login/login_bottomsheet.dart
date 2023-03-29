import 'package:flutter/material.dart';
import 'package:front_end/foundation/sp_solid_button/sp_solid_button.dart';
import 'package:front_end/foundation/theme/colors.dart';


class LoginBottomsheet extends StatefulWidget {
  const LoginBottomsheet({Key? key}) : super(key: key);

  @override
  _LoginBottomsheetState createState() => _LoginBottomsheetState();
}

class _LoginBottomsheetState extends State<LoginBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        children: [
      Row(
      children: [
      Image.asset(
        "assets/images/logo-big.png",
        height: 45,
        width: 45,
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.clear,
          size: 30,
        ),
      ),
      ],
    ),
    SizedBox(height: 35),
    RichText(
    text: TextSpan(
    children: [
    TextSpan(
    text: "Login ",
    style: TextStyle(
    color: Colors.black,
    fontSize: 19,
    fontWeight: FontWeight.bold,
    ),
    ),
    TextSpan(
    text: "or ",
    style: TextStyle(
    color: Colors.black,
    fontSize: 19,
    fontWeight: FontWeight.bold,
    ),
    ),
    TextSpan(
    text: "Signup",
    style: TextStyle(
    color: Colors.black,
    fontSize: 19,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ),
    const SizedBox(
    height: 35,
    ),
    Container(
    height: 43,
    child: TextField(
    keyboardType: TextInputType.text,
    style: TextStyle(
    color: Colors.black,
    fontSize: 19,
    ),
    decoration: InputDecoration(
    labelText: "Username/Password",
    labelStyle: TextStyle(
    color: Colors.black,
    fontSize: 19,
    fontWeight: FontWeight.bold,
    ),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
    width: 1,
    color: Colors.grey[400]!,
    ),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
    width: 1.5,
    color: Colors.black54,
    ),
    ),
    ),
    ),
    ),
    SizedBox(height: 25),
    RichText(
    text: TextSpan(
    children: [
    TextSpan(
    text: "By continuing I agree to the ",
    style: TextStyle(
    color: Colors.black,
    fontSize: 11,
    fontWeight: FontWeight.bold,
    ),
    ),
    TextSpan(
    text: "Terms of Use ",
    style: TextStyle(
    color: Colors.blue,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    ),
    ),
    TextSpan(
    text: "Privacy & Policy",
    style: TextStyle(
    color: Colors.black,
    fontSize: 11,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ),
    SizedBox(height: 30),
    SPSolidButton(text: "CONTINUE"),
    RichText(
    text: TextSpan(
    children: [
    TextSpan(
    text: "Having trouble logging in? ",
    style: TextStyle(
    color: Colors.black,
    fontSize: 12.5,
    fontWeight: FontWeight.bold,
    ),
    ),
    TextSpan(
    children: [
    TextSpan(
    text: "Get help ",
    style: TextStyle(
    color: Colors.black,
    fontSize: 13,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ],
    ),
    ),
        ],
      ),

    );
  }
}
