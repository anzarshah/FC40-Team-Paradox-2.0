import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';

class Constants {
  ///[LOGGED] user logged in
  static const int LOGGED = 0;

  ///[SKIPPED] user not logged in but skipped intro
  static const int SKIPPED = 1;

  ///[CODE_NEEDED] user signed up but didn't confirm code
  static const int CODE_NEEDED = 2;

  ///[NOT_APPROVED] user signed up but still not approved
  static const int NOT_APPROVED = 3;

  ///[STATUS] STATUS shared preferences tag
  static const String STATUS = "STATUS";

  static String formatDateTimeFromUtc(dynamic time) {
    try {
      return new DateFormat("yyyy-MM-dd hh:mm:ss")
          .format(new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(time));
    } catch (e) {
      return new DateFormat("yyyy-MM-dd hh:mm:ss").format(new DateTime.now());
    }
  }

  static String timeFormat(dynamic time) {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('hh:mm a').format(dateTime);
  }

  static String? capital(String string) {
    return intl.toBeginningOfSentenceCase(string);
  }

  static snackBar(String string, BuildContext context) {
    final snackBar = SnackBar(content: Text(string));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static bool condition(String data) {
    if (data == "1") {
      return true;
    } else {
      return false;
    }
  }
}

const Color primary = Color(0xFF365623);
const Color secondary = Color(0xFFD8E2D1);
const Color golden = Color(0xFFcc9004);
const Color greyish = Color(0xFF6c6c6c);
const Color white = Color(0xFFffffff);
// const String url = "http://10.10.0.1:8000/api/auth";
// const String ftp = "http://10.10.0.1:8000/";

const String url = "http://34.66.91.5/api/auth";
const String ftp = "http://34.66.91.5/";
const String AGORA_APP_ID = "b6dfb2b58ff440d3bd550f65d0ba11c6";

const double defaultPadding = 16.0;
const Duration defaultDuration = Duration(milliseconds: 300);
