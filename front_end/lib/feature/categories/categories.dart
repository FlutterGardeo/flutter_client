import 'package:flutter/material.dart';
import 'package:front_end/feature/login/login_bottomsheet.dart';
import 'package:front_end/foundation/theme/colors.dart';

class Categories extends StatefulWidget {

  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();

}

class _CategoriesState extends State<Categories>{

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: AppColor.scaffoldBGColor,
      body:SafeArea(child:LoginBottomsheet()),

    );

  }
}
