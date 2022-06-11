import 'package:coalesce/check.dart';
import 'package:coalesce/loadingpage.dart';
import 'package:coalesce/login_page.dart';
import 'package:coalesce/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  String? username = '';
  String? email = '';
  String? userphno = '';

  late Size _size;

  @override
  void initState() {
    userDataGetter();
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
              height: 80,
            ),
            Text(
              "Some Company",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "ICO Name: COCOCOIN",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Amount: 2000",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "ICO ID: 2F349D",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Volume in Circulation: 200",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Company ID: 9DE4GF",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 100,
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
                      // logOut();
                      Navigator.of(context).pop();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Text(
                            'Send',
                            style: TextStyle(fontSize: 20, color: greyish),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).primaryColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    onPressed: () {
                      // logOut();
                      Navigator.of(context).pop();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Text(
                            'Recieve',
                            style: TextStyle(fontSize: 20, color: greyish),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).primaryColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    onPressed: () {
                      // logOut();
                      Navigator.of(context).pop();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Text(
                            'Mint',
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

  //User data getter
  userDataGetter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var tokenCode = sharedPreferences.getString('token');
    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $tokenCode"
    };

    var response = await http.get(Uri.parse(url + '/user'), headers: header);
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        sharedPreferences.setString('user_data_name', jsonData['name']);
        sharedPreferences.setString('user_data_email', jsonData['email']);
        sharedPreferences.setString(
            'user_data_phone_number', jsonData['phone_number']);
        username = sharedPreferences.getString('user_data_name');
        email = sharedPreferences.getString('user_data_email');
        userphno = sharedPreferences.getString('user_data_phone_number');
      });
    } else {
      print(response.body);
      Constants.snackBar("Something went wrong", context);
    }
  }
  //End User Data Fetch

  //Logout function
  // logOut() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.clear();
  //   // Navigator.of(context).pushAndRemoveUntil(
  //   //     MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
  //   //     (Route<dynamic> route) => false);
  // }
}
