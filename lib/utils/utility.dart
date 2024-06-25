import 'dart:developer' as dev;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void printf(dynamic value) {
  if (!kReleaseMode) dev.log(value.toString());
}

class Utility {
  static bool isShowing = false;
  static bool isEmpty(String? string) {
    return string == null || string.isEmpty;
  }

  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Widget? hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return null;
  }

  static snackBar(String msg, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String convertTimestampToDate(int timestamp) {
    // Convert milliseconds to DateTime
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Format the date as a readable string
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);

    return formattedDate;
  }
  static String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = DateFormat('yyyy-MM-dd HH:mm').format(date);
      // return formattedDate;
      /*if (diff.inDays == 1) {
        time = '${diff.inDays} Day Ago ${format.format(date)}';
      } else {
        time = '${diff.inDays} Days Ago ${format.format(date)}';
      }*/
    } else {
      time = DateFormat('yyyy-MM-dd HH:mm').format(date);

      /*if (diff.inDays == 7) {
        time = '${(diff.inDays / 7).floor()} Week Ago ${format.format(date)}';
      } else {
        time = '${(diff.inDays / 7).floor()} Weeks Ago ${format.format(date)}';
      }*/
    }
    return time;
  }
}
