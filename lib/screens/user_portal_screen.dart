import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_client/models/option.dart';
import 'package:flutter_client/widgets/dashboard.dart';
import 'package:flutter_client/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'devices_services_screen.dart';

class UserPortal extends StatefulWidget {
  @override
  _UserPortalState createState() => _UserPortalState();
}

class _UserPortalState extends State<UserPortal> {
  @override
  Widget build(BuildContext context) {
    late final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.orange[400],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            AppBar(
              title: Text(
                "Dashboard",
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: Icon(
                Icons.ac_unit,
                color: Colors.white,
              ), // Add an icon or logo here
            ),
            SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Dashboard(
                  optionList: [
                    Option(
                      title: "Devices & Services",
                      img: "assets/products.png",
                      action: () {
                        Navigator.pushNamed(context, DevicesAndServices.routeName);
                      },
                    ),
                    // Option(
                    //   title: "Services",
                    //   img: "assets/services.png",
                    //   action: () {
                    //     print("Inside Services");
                    //   },
                    // ),
                    Option(
                      title: "Subscriptions",
                      img: "assets/subscriptions.png",
                      action: () {
                        print("Inside Subscriptions");
                      },
                    ),
                    Option(
                      title: "Logout",
                      img: "assets/log-out.png",
                      action: () async {
                        try {
                          await auth.logout();
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error.toString()),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
