import 'package:flutter/material.dart';
import 'package:front_end/feature/categories/categories.dart';
import 'package:front_end/feature/home_page/home_page.dart';
import 'package:front_end/feature/profile/profile.dart';
import 'package:front_end/foundation/sp_icon/sp_icon.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentIndex = 0;
  List<Widget> pages = [HomePage(), Categories(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xfffe416c),
        selectedLabelStyle: const TextStyle(fontSize: 13),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SPIcon(
              assetName: "logo-black.png",
              isSelected: currentIndex == 0,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SPIcon(
              assetName: "categories.png",
              isSelected: currentIndex == 1,
            ),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: SPIcon(
              assetName: "profile.png",
              isSelected: currentIndex == 2,
            ),
            label: "Profile",
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
