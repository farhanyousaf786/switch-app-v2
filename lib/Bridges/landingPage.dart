import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switchapp/Authentication/Auth.dart';
import 'package:switchapp/Authentication/SignIn/SignInPage.dart';
import 'package:switchapp/Authentication/SignUp/emailVerification.dart';
import 'package:switchapp/Bridges/bridgeToNavgation.dart';
import 'package:switchapp/Bridges/bridgeToSetEmailVerification.dart';
import 'package:switchapp/MainPages/NavigationBar/NavigationBar.dart';
import 'package:switchapp/Models/Constans.dart';
import 'package:switchapp/UniversalResources/DataBaseRefrences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    _setNotificationCounter();
    intro();
  }

  intro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt("intro") == null) {
      prefs.setInt("intro", 0);

      print("intro: ${prefs.getInt("intro")}");

      Constants.isIntro = "true";
    } else {
      if (prefs.getInt("intro")! <= 0) {
        print("intro: ${prefs.getInt("intro")}");
        Constants.isIntro = "true";
      } else {
        print("intro: ${prefs.getInt("intro")}");
        Constants.isIntro = "false";
      }
      //  followSwitchId();
      // bottomSheetForFollowing();
    }
  }

  _setNotificationCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("notifyCounter", "0");
    setState(() {
      Constants.notifyBell = true;
      // Constants.messageIconActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// auth for checking that user is signIn or Not
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;

            if (user == null) {
              return SignInPage();
            } else if (!user.emailVerified) {
              ///Main page take us to transation to one to another page through Navigation bar

              return BridgeToSetEmailVerification();
            } else {
              return Provider<User>.value(
                value: user,
                child: BridgeToNavigationPage(
                  user: user,
                ),
              );
            }
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          }
        });
  }
}
