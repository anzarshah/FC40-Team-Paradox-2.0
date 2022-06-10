// import 'package:coalesce/MainArrange.dart';
// import 'package:dhatnoon/loginpage.dart';
// import 'package:dhatnoon/navigationpage.dart';
import 'package:coalesce/splash.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:provider/provider.dart';
// import 'locationprovider.dart';
import 'constants.dart';
import 'dart:async';
// import 'package:camera/camera.dart';
// import 'notification_service.dart';

Future<void> main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white38,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.symmetric(
              vertical: defaultPadding * 1.2, horizontal: defaultPadding),
        ),
      ),
    );
  }
}
