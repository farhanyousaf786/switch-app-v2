
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switchapp/Bridges/landingPage.dart';
import 'package:switchapp/Models/Constans.dart';

// ignore: camel_case_types
class AppIntro extends StatefulWidget {
  @override
  _AppIntroState createState() => _AppIntroState();
}

// ignore: camel_case_types
class _AppIntroState extends State<AppIntro> {


  bottomSheetForSkipButton(BuildContext context) {
    return showModalBottomSheet(
        useRootNavigator: true,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        barrierColor: Colors.blue.withOpacity(0.4),
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "It seems, you SKIP introduction. You can always watch intro. by visiting Switch tab at bottom right corner.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'cutes'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "We recommend to visit intro. to understand app better.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          fontFamily: 'cutes'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.setInt("intro", 1);
                            if(mounted)
                            setState(() {
                              Constants.isIntro = "";
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 50,
                            width: MediaQuery.of(context).size.width/2.5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Watch Later",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LandingPage(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 50,
                            width: MediaQuery.of(context).size.width/2.5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Watch Now",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

