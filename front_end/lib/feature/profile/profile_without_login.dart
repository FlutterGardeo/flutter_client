import 'package:flutter/material.dart';
import 'package:front_end/feature/profile/profile_footer_content.dart';
import 'package:front_end/foundation/theme/colors.dart';
import '../../foundation/profile_item/profile_item.dart';

class ProfileWithoutLogin extends StatefulWidget {
  const ProfileWithoutLogin({Key? key}) : super(key: key);
  final double topContainerHeight = 190;

  @override
  _ProfileWithoutLoginState createState() => _ProfileWithoutLoginState();
}

class _ProfileWithoutLoginState extends State<ProfileWithoutLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.topContainerHeight,
          child: Stack(
            children: [
              Container(
                height: widget.topContainerHeight * 0.58,
                color: AppColor.dummyBGColor,
              ),
              Container(
                height: widget.topContainerHeight * 0.42,
                color: AppColor.whiteColor,
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  height: 132,
                  width: 132,
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: Image.asset("assets/images/user.png"),
                    ),
                    color: AppColor.bodyColor2,
                  ),
                ),
              ),
              Positioned(
                bottom: 22,
                left: 168,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: AppColor.buttonColor,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 215,
                    height: 45,
                    child: Text("LOG IN/SIGN UP"),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        FooterContent(),
        const SizedBox(
          height: 40,
        ),
        Container(
          color: AppColor.whiteColor,
          child: Column(
            children: [
              ProfileItem(
                title: "Orders",
                subtitle: "Check your order status",
                assetName: "orders.png",
                isLast: false,
              ),
              ProfileItem(
                title: "Help center",
                subtitle: "Help regarding your recent purchase",
                assetName: "help-desk.png",
                isLast: false,
              ),
              ProfileItem(
                title: "Wishlist",
                subtitle: "Your most loved mobile accessories",
                assetName: "wishlist.png",
                isLast: false,
              ),
              ProfileItem(
                title: "Tier",
                subtitle: "Your tier",
                assetName: "tier.png",
                isLast: true,
              ),
            ],
          ),
        ),
        FooterContent(),
        Text("APP VERSION: 0.0.1", style: Theme.of(context).textTheme.overline!),
      ],
    );
  }
}
