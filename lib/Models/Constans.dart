import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Constants {
  static int notifyCounter = 0; // to control Notification when app opens
  static String uploadUrl = "";
  static String myName = "";
  static String mySecondName = "";
  static String myEmail = "";
  static String myId = "";
  static String myPhotoUrl = "";
  static String globalGroupChatId = "";
  static String mood = "";
  static String moodUrl = "";
  static String gender = "";
  static String country = "";
  static String dob = "";
  static String about = "";
  static String username = "";
  static String isVerified = "";
  static String groupChatId = "";
  static String follower = "";
  static String following = "";
  static List allMemes = [];
  static String notificationContent = "";
  static String notificationType = "";

  //hard code ids for important users
  static String switchId = "l9YFPY9yDqNqFcsi4gxIbL5RRGL2";
  static String switchIdFarhan = "T32SFNtIWMTsozx7HBF02c8Uk4d2";
  static String switchIdLaaSY = "h84QW4Tl9CdRXomduiNFeGUv1iY2";
  // variable to store pass temporary to store in database
  static String pass = "";
  // variable to initialize app intro if app newly install
  static String isIntro = "";
  // variable to initialize app intro if app newly install
  static String isIntroForMemeProfile = "";
  // variable to initialize app intro if app newly install
  static String introForChatListPage = "";
  // a very important variable to control theme of app.
  // if theme is dark, it will become true
  static String isDark = "false";
  static bool notifyBell = true;
  static bool messageIconActive = false;
  static String isMessageReply = "no";






  String inRelationshipWithId = "";
  static String token = "";

  static String currentMoodGlobal = "happy";
  static int counter = 10;

  static const double padding = 20;
  static const double avatarRadius = 45;


  ///*** Love Note Variables ***\\\

  static String content = "";
  static String imageUrl = "";
  static String timeStamp = "";
}
