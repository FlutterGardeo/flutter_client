import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_client/models/option.dart';
import 'package:flutter_client/widgets/dashboard.dart';
import 'package:flutter_client/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'devices_services_screen.dart';

class AdminPortal extends StatefulWidget {
  @override
  _AdminPortalState createState() => _AdminPortalState();
}

class _AdminPortalState extends State<AdminPortal> {
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
                "Admin Dashboard",
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
                      title: "Add",
                      img: "assets/add.png",
                      action: () {
                        print("Inside Add");
                      },
                    ),
                    Option(
                      title: "Update",
                      img: "assets/update.png",
                      action: () {
                        print("Inside Update");
                      },
                    ),
                    Option(
                      title: "Delete",
                      img: "assets/delete.png",
                      action: () {
                        print("Inside Delete");
                      },
                    ),
                    Option(
                      title: "Devices & Services",
                      img: "assets/products.png",
                      action: () {
                        Navigator.pushNamed(
                            context, DevicesAndServices.routeName);
                      },
                    ),
                    Option(
                      title: "Logout",
                      img: "assets/log-out.png",
                      action: () async {
                        try {
                          await auth.logout();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
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
