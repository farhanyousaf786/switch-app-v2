import 'package:firebase_database/firebase_database.dart';

import 'DataBaseRefrences.dart';

class UniversalMethods {


  List posts = [];
  Future<List> getUserPostRtd(String uid, int limit) async {
    List followingList = [];

    userFollowingRtd.child(uid).once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        Map data = dataSnapshot.value;
        Map data2;

        data.forEach(
                (index, data) => followingList.add({"key": index, ...data}));


        for (int i = 0; i <= followingList.length; i++) {

          postsRtd
              .child("${followingList[i]['followingId']}")
              .child("usersPost")
              .orderByChild("timestamp")
              .limitToLast(limit)
              .once()
              .then((DataSnapshot dataSnapshot) {
            if (dataSnapshot.value != null) {
              data2 = dataSnapshot.value;

              data2
                  .forEach((index, data) => posts.add({"key": index, ...data}));

              posts.sort((a, b) {
                return a["timestamp"].compareTo(b["timestamp"]);
              });
            }
          });
        }

        return posts;


      } else {
        print("There is no post");
        return posts;
      }
    });
    return posts;

  }


  String shortNumberGenrator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }




}
