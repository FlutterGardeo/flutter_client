import 'package:flutter/material.dart';
import 'package:front_end/feature/profile/profile_without_login.dart';
import 'package:front_end/foundation/theme/colors.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBGColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        centerTitle: false,
        title: Padding(
         padding: const EdgeInsets.only(left: 10),
            child: Text("Profile",style: Theme.of(context).textTheme.headline6,)
        ),
      ),
      body: SingleChildScrollView(child:ProfileWithoutLogin()),
    );
  }
}
