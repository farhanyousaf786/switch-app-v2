/*

This class will control the flow if
user forgot his/her password


 */

import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:switchapp/Bridges/landingPage.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  // here wew create the object of firebase class to access our firebase
  // that we have connected to our application
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // This is a variable (String type) to store the email that user
  // will put in text field
  TextEditingController emailTextEditingController = TextEditingController();

  // this variable will control the flow of screen, before and after the press button
  // for forget password
  bool isSent = false;

  // this function will run every time, when user tap on switch button
  // this function is to remove any type of space from user input
  void formatNickname() {
    emailTextEditingController.text =
        emailTextEditingController.text.replaceAll(" ", "");
  }

  // this function will be responsible to execute upper function as soon
  // user complete the input

  // This is the function to send request to firebase to reset password
  resetPassword() async {

    formatNickname();

    print(emailTextEditingController.text);

    try {
      await _firebaseAuth.sendPasswordResetEmail(
          email: emailTextEditingController.text);
      setState(() {
        isSent = true;
      });
    } catch (e) {
      // This is bottom sheet will pop up is any error occurs
      showModalBottomSheet(
          useRootNavigator: true,
          isScrollControlled: true,
          barrierColor: Colors.red.withOpacity(0.2),
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height / 3,
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                          height: 150,
                          width: 150,
                          child: Lottie.asset("images/error.json")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "This email is incorrect or did not exist",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "cutes",
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This is our main widget of every screen we displayed to the user
    // it has whole screen. Inside this widget we create all widget of the
    // screen

    return Scaffold(
      // simple appBar
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: Colors.lightBlue,
      body: !isSent
          ? Column(
              children: [
                SizedBox(
                  height: 0,
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: RiveAnimation.asset(
                    'images/authLogo.riv',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25, top: 0),
                  child: Text(
                    "Recovery Mood",
                    style: TextStyle(
                      fontFamily: "Cute",
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Enter Email for reset password",
                    style: TextStyle(
                      fontFamily: "Cute",
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontSize: 12,
                        fontFamily: "Cute",
                      ),
                      controller: emailTextEditingController,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              new BorderSide(color: Colors.white, width: 2),
                        ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              new BorderSide(color: Colors.white, width: 2),
                        ),
                        labelText: ' Email',
                        labelStyle: TextStyle(
                          fontFamily: "Cute",
                          color: Colors.blue.shade900,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => resetPassword(),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          fontFamily: "Cute",
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: RiveAnimation.asset(
                    'images/authLogo.riv',
                  ),
                ),
                Text(
                  "Open your ${emailTextEditingController.text} email account to reset password, and signIn by clicking Ok Button",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Cute",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingPage())),
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      width: 80,
                      height: 45,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Ok",
                            style: TextStyle(
                              fontFamily: "Cute",
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                DelayedDisplay(
                  delay: Duration(seconds: 1),
                  slidingBeginOffset: Offset(0.0, -1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LandingPage())),
                        },
                        child: Container(
                            padding:
                                EdgeInsets.only(top: 60, left: 20, right: 20),
                            child: Text(
                              "Back",
                              style: TextStyle(
                                fontFamily: "Cute",
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 60, left: 20, right: 20),
                          child: RaisedButton(
                            focusColor: Colors.white,
                            highlightColor: Colors.white,
                            elevation: 0,
                            textColor: Colors.blue.shade700,
                            color: Colors.blue.withOpacity(0.1),
                            child: Text(
                              'Need Help',
                              style: TextStyle(
                                fontFamily: "Cute",
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
