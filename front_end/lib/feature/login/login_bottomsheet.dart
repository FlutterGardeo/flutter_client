import 'package:flutter/material.dart';
import 'package:front_end/foundation/theme/colors.dart';

class LoginBottomsheet extends StatefulWidget {

  const LoginBottomsheet({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context){
  return Container(
    height: MediaQuery.of(context).size.height/2,
    color: AppColor.whiteColor,
  );
  }


