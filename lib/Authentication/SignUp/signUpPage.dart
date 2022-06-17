import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:switchapp/Authentication/Auth.dart';
import 'package:switchapp/Authentication/SignIn/SignInPage.dart';
import 'package:switchapp/Authentication/SignUp/emailVerification.dart';
import 'package:switchapp/Authentication/userAgreementPage.dart';
import 'package:switchapp/Bridges/bridgeToSetEmailVerification.dart';
import 'package:switchapp/Models/Constans.dart';
import 'package:switchapp/UniversalResources/DataBaseRefrences.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController userNameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();
  bool _isHidden = true;
  FocusNode _passFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  List userList = [];
  List userList2 = [];

  late Map<dynamic, dynamic> values;
  bool userListEmpty = false;
  bool userExists = false;
  bool userExistsText = false;

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passFocusNode);
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    super.initState();

    getAllUsers();
  }

  getAllUsers() {
    userRefForSearchRtd.once().then((DataSnapshot snapshot) {
      values = snapshot.value;
      List userList = [];
      if (values == null) {
        setState(() {
          userListEmpty = true;
        });
      } else {
        setState(() {
          values
              .forEach((index, data) => userList.add({"user": index, ...data}));
        });
        setState(() {
          this.userList = userList;
        });
      }
    });
  }

  void formatNickname() {
    emailTextEditingController.text =
        emailTextEditingController.text.replaceAll(" ", "");
  }

  Future<void> signUp() async {
    formatNickname();
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);

      await auth.createUserWithEmailAndPassword(
          emailTextEditingController.text, passwordTextEditingController.text);

      setState(() {
        isLoading = false;
        Constants.pass = passwordTextEditingController.text;
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BridgeToSetEmailVerification(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showModalBottomSheet(
          useRootNavigator: true,
          isScrollControlled: true,
          barrierColor: Colors.red.withOpacity(0.2),
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.5,
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
                        "This email or password is incorrect, or already been taken",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "cutes",
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Note:  Check your internet too.",
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: "cutes",
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

  userValidater(String userName) {
    if (userName.isNotEmpty) {
      setState(() {
        userList2 = userList;
      });
      int trendIndex = userList.indexWhere((f) =>
          f['userName'] == userNameTextEditingController.text.toLowerCase());

      if (trendIndex == -1) {
        print("not exists");

        setState(() {
          userExists = false;
        });
      } else {
        print("exists");
        setState(() {
          userExists = true;
        });
      }

      print(userList2.length);
    } else {
      print("empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "",
          style: TextStyle(
            fontFamily: "Cute",
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: Container(
        color: Colors.lightBlue,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: DelayedDisplay(
            delay: Duration(microseconds: 100),
            slidingBeginOffset: Offset(1, 0.0),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 200,
                  child: RiveAnimation.asset(
                    'images/authLogo.riv',
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 25, top: 0),
                  child: Text(
                    "Please Sign Up",
                    style: TextStyle(
                      fontFamily: "Cute",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                    child: TextField(
                      onEditingComplete: _emailEditingComplete,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontSize: 12,
                        fontFamily: "Cute",
                      ),
                      onTap: () => userValidater(
                          userNameTextEditingController.text.toLowerCase()),
                      // onChanged: (values) {

                      // },
                      focusNode: _emailFocusNode,
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
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            fontFamily: "Cute",
                            color: Colors.blue.shade900,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                    child: TextField(
                      obscureText: _isHidden,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _passFocusNode,
                      style: TextStyle(
                        fontFamily: "Cute",
                        color: Colors.blue.shade900,
                        fontSize: 12,
                      ),
                      controller: passwordTextEditingController,
                      onEditingComplete: signUp,
                      decoration: InputDecoration(
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Icon(
                              _isHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
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
                        labelText: ' Password',
                        labelStyle: TextStyle(
                          fontFamily: "Cute",
                          color: Colors.blue.shade900,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                // userList2.isNotEmpty
                //     ? SizedBox(
                //         height: 150,
                //         child: ListView.builder(
                //             itemCount: userList2.length,
                //             itemBuilder: (context, index) {
                //               return _returnValue(userList, index);
                //             }),
                //       )
                //     : Text(""),

                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserAgreementPage(),
                      ),
                    ),
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: "By signing up you agree to our ",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontFamily: 'cutes',
                                )),
                            TextSpan(
                              text: 'Terms & Conditions.',
                              style: TextStyle(
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cutes',
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 35,
                    width: 100,
                    child: RaisedButton(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                              color: Colors.blue.shade700,
                            )),
                        color: Colors.blue.shade50,
                        child: isLoading
                            ? SpinKitFadingCircle(
                                color: Colors.blue.shade700,
                                size: 18,
                              )
                            : Text(
                                'Switch',
                                style: TextStyle(
                                  color: userExists
                                      ? Colors.blue.shade300
                                      : Colors.blue.shade700,
                                  fontFamily: "Cute",
                                ),
                              ),
                        onPressed: () => {
                              if (emailTextEditingController.text.isEmpty ||
                                  passwordTextEditingController.text.isEmpty)
                                {
                                  showModalBottomSheet(
                                      useRootNavigator: true,
                                      isScrollControlled: true,
                                      barrierColor: Colors.red.withOpacity(0.2),
                                      elevation: 0,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.5,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons
                                                          .linear_scale_sharp),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Container(
                                                      height: 150,
                                                      width: 150,
                                                      child: Lottie.asset(
                                                          "images/error.json")),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Email or password can\'t be empty',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: "cutes",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                }
                              else
                                {
                                  setState(() {
                                    isLoading = true;
                                  }),
                                  signUp(),
                                }
                            }),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     height: 50,
                //     padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                //     child: TextField(
                //       obscureText: _isHidden,
                //
                //       keyboardType: TextInputType.url,
                //       textInputAction: TextInputAction.done,
                //       style: TextStyle(
                //
                //         color: Colors.blue.shade900,
                //         fontSize: 12,
                //         fontFamily: "Cute",
                //       ),
                //       controller: passwordTextEditingController,
                //       decoration: InputDecoration(
                //         suffix: InkWell(
                //           onTap: _togglePasswordView,
                //           child: Icon(
                //             _isHidden
                //                 ? Icons.visibility
                //                 : Icons.visibility_off,
                //             size: 16,
                //           ),
                //         ),
                //         fillColor: Colors.transparent,
                //         isDense: true,
                //         enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(
                //             Radius.circular(20),
                //           ),
                //           borderSide:
                //               new BorderSide(color: Colors.white, width: 2),
                //         ),
                //         filled: true,
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(
                //             Radius.circular(20),
                //           ),
                //           borderSide:
                //               new BorderSide(color: Colors.white, width: 2),
                //         ),
                //         labelText: 'Password',
                //         labelStyle: TextStyle(
                //             fontFamily: "Cute",
                //             color: Colors.blue.shade900,
                //             fontSize: 12),
                //       ),
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                      child: Row(
                    children: <Widget>[
                      Text(
                        "Already Have An Account?",
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontFamily: "Cute",
                        ),
                      ),
                      FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontFamily: "Cute",
                              fontSize: 20,
                              color: Colors.greenAccent,
                            ),
                          ),
                          onPressed: () => {
                                print("isLoading => $isLoading"),
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInPage()))
                              }),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
