import 'package:delayed_display/delayed_display.dart';
import 'package:emojis/emoji.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switchapp/Authentication/Auth.dart';
import 'package:switchapp/Bridges/landingPage.dart';
import 'package:switchapp/MainPages/AppSettings/privacyPolicy.dart';
import 'package:switchapp/MainPages/ReportAndComplaints/complaintPage.dart';
import 'package:switchapp/Models/Constans.dart';
import 'package:switchapp/UniversalResources/DataBaseRefrences.dart';
import 'package:switchapp/UniversalResources/ThemeMode.dart';
import 'package:timelines/timelines.dart';

import '../ReportAndComplaints/postReportPage.dart';

class AppSettings extends StatefulWidget {
  final User user;

  AppSettings({required this.user});

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  Future<void> signOut() async {
    userRefRTD.child(widget.user.uid).update({"isOnline": "false"});

    final auth = Provider.of<AuthBase>(context, listen: false);

    await auth.signOut();
  }

  List<Emoji> emList = Emoji.all(); // list of all Emojis
  List roadMapList = [
    "Launch Switch App",
    "Image Meme Posting",
    "Meme Ranking",
    "Clusty Chat",
    "Profile Rating",
    "Memer Ranking",
    "Memer Decency",
    "Profile Decency",
    "Video Meme Posting",
    "Group Chat",
    "MEME Competition will be added (b/w) Memer's Followers",
    "Meme Tournament (B/w) Memers",
    "Chat List Search",
    "Dark theme",
    "Clusty Friend",
    "Chat emoji",
    "Voice & Video Call",
    "Camera Filters",
    "will add more language",
  ];

  @override
  void initState() {
    super.initState();
    // getNotification();
  }

  // getNotification() {
  //   feedRtDatabaseReference
  //       .child(Constants.myId)
  //       .child("feedItems")
  //       .orderByChild("timestamp")
  //       .limitToLast(1)
  //       .onChildAdded
  //       .listen((data) {
  //     Map nData = data.snapshot.value;
  //     Future.delayed(const Duration(seconds: 1), () {
  //       //  widget.notification();
  //     });
  //   });
  // }

  TextEditingController userText = TextEditingController();

  _openBottomSheet(String type) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.linear_scale_sharp),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    type,
                    style: TextStyle(
                        fontSize: 20, fontFamily: "cute", color: Colors.pink),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    maxLength: 500,
                    style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    controller: userText,
                    decoration: InputDecoration(
                      fillColor: Colors.blue.shade50.withOpacity(0.5),
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide: new BorderSide(
                            color: Colors.blue.shade700, width: 1),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: new BorderSide(
                            color: Colors.blue.shade700, width: 1),
                      ),
                      labelText: ' Write Here',
                      labelStyle: TextStyle(
                        fontFamily: "Cutes",
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  elevation: 0.0,
                  onPressed: () => {
                    reportRTD.child(Constants.myId).push().set({
                      "type": "postReport",
                      "postId": "",
                      "description": userText.text,
                      "reportId": "",
                      "reportSenderId": Constants.myId,
                    }),
                    Fluttertoast.showToast(
                      msg: "Message sent, Wait for response",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.blue.withOpacity(0.8),
                      textColor: Colors.white,
                      fontSize: 16.0,
                    ),
                    Navigator.pop(context),
                  },
                  child: Text("Send"),
                  color: Colors.blue.shade50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  whatsNewSlid() {
    return showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        barrierColor: Colors.red.withOpacity(0.2),
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.linear_scale_sharp),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Whats New?",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "cute",
                          color: Colors.green.shade700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Container(
                            child: Flexible(
                                child: Text(
                          "Earn Money through Slit points:",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'cute',
                              fontSize: 17),
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Container(
                            child: Flexible(
                                child: Text(
                          "You can earn money through Slits. Slit points can be earn by upload new meme, When someone like your meme, when you participate on meme competition.",
                          style: TextStyle(
                              color: Colors.blue.shade700,
                              fontFamily: 'cutes',
                              fontSize: 13),
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Container(
                            child: Flexible(
                                child: Text(
                          "Meme Competition:",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'cute',
                              fontSize: 17),
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Container(
                            child: Flexible(
                                child: Text(
                          "Now, every user can participate in meme competition, Directly.",
                          style: TextStyle(
                              color: Colors.blue.shade700,
                              fontFamily: 'cutes',
                              fontSize: 13),
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Container(
                            child: Flexible(
                                child: Text(
                          "Monthly prize for top 3 Memers:",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'cute',
                              fontSize: 17),
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Container(
                            child: Flexible(
                                child: Text(
                          "You can earn monthly prize up to 1000 pkr if you held one of top 3 slot in Switch App as a Memer.",
                          style: TextStyle(
                              color: Colors.blue.shade700,
                              fontFamily: 'cutes',
                              fontSize: 13),
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Version 1.10",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                            fontFamily: 'cutes'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Switch",
          style:
              TextStyle(color: Colors.white, fontFamily: 'cute', fontSize: 28),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Center(
              child: Text(
            "Log Out",
            style: TextStyle(
                color: Colors.white, fontFamily: 'cute', fontSize: 15),
          )),
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
                size: 20,
              ),
              onPressed: signOut),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: RiveAnimation.asset(
                'images/authLogo.riv',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        // color: Colors.white60,
                        // borderRadius: BorderRadius.circular(20),
                        ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Our Goal",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontFamily: 'cute'),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: Text(
                              "Memes are holding the advertising industry indirectly and directly."
                              " Our plan is to make this platform an original meme content genrator."
                              " First a meme must be generate here and the it should viral to other social platforms."
                              "Moreover, we want to make this platform an earning source for memers. Hope it will go well.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'cutes'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            widget.user.uid == Constants.switchIdLaaSY
                ? SizedBox(
                    width: 0,
                    height: 0,
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.white60,
                            // borderRadius: BorderRadius.circular(20),
                            ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) =>
                                          Colors.white.withOpacity(0.5)),
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          Colors.green.withOpacity(0.9))),
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setInt("intro", 0);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LandingPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Watch introduction",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'cute'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            widget.user.uid == Constants.switchIdLaaSY
                ? SizedBox(
                    width: 0,
                    height: 0,
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.white60,
                            // borderRadius: BorderRadius.circular(20),
                            ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) =>
                                          Colors.white.withOpacity(0.5)),
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          Colors.blue.withOpacity(0.9))),
                              onPressed: () => {whatsNewSlid()},
                              child: Text(
                                "Whats New",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'cute'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ComplaintUs()))
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "Send Us Complaint",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cutes',
                          fontSize: 13),
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy())),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "Terms of use & Privacy Policy",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cutes',
                          fontSize: 13),
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "Switch App",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    fontFamily: 'cutes'),
              )),
            ),
            GestureDetector(
              onTap: () => {},
              child: Center(
                child: Text(
                  "Version 1.10",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                      fontFamily: 'cutes'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
