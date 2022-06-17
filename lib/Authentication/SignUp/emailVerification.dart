/*

This class will handle user to get their email verification

 */

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:switchapp/Authentication/Auth.dart';
import 'package:switchapp/Authentication/SignIn/SignInPage.dart';
import 'package:switchapp/Authentication/SignUp/SetUserData.dart';
import 'package:switchapp/Bridges/bridgeToSetEmailVerification.dart';
import 'package:switchapp/Models/Constans.dart';
import 'package:switchapp/UniversalResources/DataBaseRefrences.dart';

class EmailVerification extends StatefulWidget {

  // This is object of class User and we passed it as parameter, it has basic info of our user
  final User user;

  EmailVerification({required this.user, });

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {

  // Firebase auth instant object to check
  // if user verified by email or not

  final auth = FirebaseAuth.instance;

  late User user;

  late Timer timer;

  String countryName = 'Select Country';


  // this function will always run one time
  // when we came to this class
  @override
  void initState() {
    super.initState();
    user = auth.currentUser!;
    user.sendEmailVerification();
    defaultUserInfo();

  }


  // this information will store to firebase as soon as a user tap our Switch button from sign up page
  // after tap our app lead our user to this page and for security we will store this info at very first
  // moment as default info. We did it because may be user exit the app or may be he close app accidently
  // after tap on switch button from signup class. So we make sure that the user with that email has his
  // store in database. So we can use this and make our decision on the basis of this info so that user
  // can set his/her own info when he start application

  defaultUserInfo() async {
    final user = Provider.of<User>(context, listen: false);
    userRefRTD.child(user.uid).set({
      "username": "",
      "androidNotificationToken": "",
      "ownerId": user.uid,
      "firstName": "",
      "secondName": "",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "email": user.email,
      "dob": "01/01/2000",
      "country": countryName,
      'isBan': "false",
      'postId': "N/A",
      'url':
      "https://firebasestorage.googleapis.com/v0/b/double-slit-world.appspot.com/o/StaticFiles%2Flogo.png?alt=media&token=45a8c220-a473-431f-934d-335527ce3a86",
      "currentMood": "Happy",
      "about": "notSet",
      'gender': "notSet",
      "isVerified": "false",
      "password": Constants.pass,
    });
    userProfileDecencyReport.child(user.uid).update({
      "numberOfOne": 0,
      "numberOfTwo": 0,
      "numberOfThree": 0,
      "numberOfFour": 0,
      "numberOfFive": 0,
    });
    memeProfileRtd.child(user.uid).set({
      "isMemer": "Yes",
      "totalMemes": 0,
      "numberOfOne": 0,
      "numberOfTwo": 0,
      "numberOfThree": 0,
      "numberOfFour": 0,
      "numberOfFive": 0,
    });
    memerPercentageDecencyRtd.child(user.uid).set({
      "PercentageDecency": 0,
      'uid': user.uid,
    });

    relationShipReferenceRtd.child(user.uid).set({
      "inRelationshipWithId": "",
      "inRelationshipWithSecondName": "",
      "inRelationshipWithFirstName": "",
      "inRelationShip": false,
      "pendingRelationShip": false,
      "inRelationshipWith": "",
    });
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Provider<User>.value(
              value: widget.user,
              child: SetUserData(
                user: widget.user,
              ),),),);
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkEmailVerified();
    });
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignInPage()))),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: Text(
          "Verification",
          style: TextStyle(
            fontSize: 25,
            fontFamily: "cute",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                child: RiveAnimation.asset(
                  'images/authLogo.riv',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "An Email Has been sent to",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'cute',
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "${user.email}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'cute',
                    color: Colors.blue.shade900,
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Kindly open your email and click to link to verify.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'cute',
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),


              SizedBox(
                height: 30,
              ),
              Text(
                "Already Verified?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'cutes',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              GestureDetector(
                onTap: () => checkEmailVerified(),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "click Here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'cutes',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      useRootNavigator: true,
                      isScrollControlled: true,
                      barrierColor: Colors.red.withOpacity(0.2),
                      elevation: 0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 4,
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
                                    "Kindly Review the below Lines",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "cutes",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "* Check that, the email you put is correct? \n"
                                    "* Check your internet connection. \n",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "cutes",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    "Did not receive Email? click here",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'cute',
                      fontSize: 10,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
