// import 'package:dhatnoon/MainArrange.dart';
import 'package:coalesce/check.dart';
import 'package:coalesce/main_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
// page import
// import 'loginpage.dart';
// import 'package:dhatnoon/mainpage.dart';
// import 'profilepage.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  var jsonData;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.home_max_outlined,
            text: 'Home',
            onTap: () {
              MainPage();
            },
          ),
          // createDrawerBodyItem(
          //     icon: Icons.event_note, text: 'Events', onTap: () {}),
          // createDrawerBodyItem(
          //     icon: Icons.notifications_active,
          //     text: 'Notifications',
          //     onTap: () {}),
          Divider(),
          createDrawerBodyItem(
              icon: Icons.account_circle_outlined,
              text: 'Profile',
              onTap: () {
                // profilePage();
              }),
          createDrawerBodyItem(
              icon: Icons.logout_rounded,
              text: 'Logout',
              onTap: () {
                logOut();
              }),
          ListTile(
            title: Text('1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget createDrawerBodyItem(
      {IconData icon = Icons.ac_unit,
      String text = "",
      GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                // fit: BoxFit.fill, image: AssetImage('images/bg_header.jpeg')
                fit: BoxFit.fill,
                image: Image.asset('assets/logo.jpeg').image)),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Coalesce",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  mainPage() async {
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (BuildContext context) => MainArrange()),
    //     (Route<dynamic> route) => false);
  }

  // profilePage() async {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => ProfilePage()));
  // }

  // void _restartApp() async {
  //   await Phoenix.rebirth(context);
  // }

//Logout Function
  logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    // _restartApp();
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    //   // (Route<dynamic> route) => false
    // );
  }
}
