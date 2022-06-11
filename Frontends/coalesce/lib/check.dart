import 'package:coalesce/apply_for_ico.dart';
import 'package:coalesce/approval.dart';
import 'package:coalesce/ico_check.dart';
import 'package:coalesce/loadingpage.dart';
import 'package:coalesce/login_page.dart';
import 'package:coalesce/main_page.dart';
import 'package:coalesce/navigation_page.dart';
import 'package:coalesce/rejection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  String? username = '';
  String? email = '';
  String? userphno = '';

  var user_id;

  late Size _size;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: NavPage(),
      appBar: AppBar(
        leading: InkWell(
          customBorder: new RoundedRectangleBorder(),
          onTap: () => _scaffoldKey.currentState!.openDrawer(),
          // splashColor: Theme.of(context).primaryColor,
          child: new Icon(
            Icons.menu,
            size: 24,
            color: golden,
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text("", style: TextStyle(color: greyish)),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh_outlined,
              color: golden,
            ),
            onPressed: () {
              setState(() {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        // builder: (BuildContext context) => MainPage()),
                        builder: (BuildContext context) => MainPage()),
                    (Route<dynamic> route) => false);
              });
              // do something
            },
          )
        ],
      ),
      body: Container(
          child: _isLoading
              ? Center(
                  child: RotatingWaves(
                  centered: true,
                ))
              : bodyContent()),
    );
  }

//Body builder content

  bodyContent() {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: Container(
                alignment: Alignment(0.0, 2.5),
                child: CircleAvatar(
                  backgroundImage: Image.asset('assets/logo.jpeg').image,
                  radius: 60.0,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Click to check your status.",
              style: TextStyle(
                  fontSize: 18.0,
                  color: golden,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).primaryColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    onPressed: () {
                      redirector();
                      // Navigator.of(context).pop();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Text(
                            'Tap',
                            style: TextStyle(fontSize: 20, color: greyish),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  redirector() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user_id = sharedPreferences.getString('user_id');
    username = sharedPreferences.getString('user_data_name');
    email = sharedPreferences.getString('user_data_email');
    // try {
    _isLoading = false;
    Map<String, String> data = {"user_id": user_id};
    Map<String, String> header = {
      "Accept": "application/json",
    };
    var jsonData = null;

    if (user_id == '') {
      snackBar("user_id cannot be left blank", context);
      _isLoading = false;
      setState(() {});
    } else {
      var response = await http.post(Uri.parse(url + "/data_fetch"),
          body: data, headers: header);
      jsonData = json.decode(response.body);
      print(response.body);
      if (response.statusCode != 200) {
        snackBar("Wrong credentials or account doesnt exist", context);
        _isLoading = false;
        setState(() {});
      } else {
        setState(() async {
          _isLoading = false;
          // SharedPreferences.setMockInitialValues({});
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(
          //         // builder: (BuildContext context) => MainPage()),
          //         builder: (BuildContext context) => CheckPage()),
          //     (Route<dynamic> route) => false);
          if (jsonData["whitepaper_check"] == 0) {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApplyForICO()),
              );
            });
          } else if (jsonData["approval_check"] == 0) {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Approval()),
              );
            });
          } else if (jsonData["accept_deny_check"] == 0) {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rejection()),
              );
            });
          } else if (jsonData["ico_creation_flag"] == 0) {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IcoCheck()),
              );
            });
          } else {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            });
          }
        });
      }
    }
  }

  static snackBar(String string, BuildContext context) {
    final snackBar = SnackBar(content: Text(string));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //User data getter

}
