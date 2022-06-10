// import 'package:dhatnoon/Loadingpage/loadingpage.dart';
// import 'package:dhatnoon/MainArrange.dart';
import 'package:coalesce/apply_for_ico.dart';
import 'package:coalesce/approval.dart';
import 'package:coalesce/approval_in_process.dart';
import 'package:coalesce/main_page.dart';
import 'package:coalesce/rejection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:developer';
import 'package:intl/intl.dart' as intl;
import 'constants.dart';
import 'login_page.dart';
import 'dart:io';
// import 'Mainpage/Design/utils/theme.dart';
// import 'Mainpage/Design/utils/DarkThemeProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _isShowSignUp = false;
  // bool _isLogin = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  //Form Fields
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupPasswordcController = new TextEditingController();
  TextEditingController signupPhoneNoController = new TextEditingController();

  FocusNode myFocusNode = new FocusNode();

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    checkLoginStatus();
    setUpAnimation();
    super.initState();
  }

  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString('token'));
    if (sharedPreferences.getString('token') != null) {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (BuildContext context) => MainArrange()),
      //     (Route<dynamic> route) => false);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: defaultDuration,
                    top: _size.height * 0.1,
                    left: 0,
                    right: _isShowSignUp
                        ? -_size.width * 0.06
                        : _size.width * 0.06,
                    child: _isShowSignUp
                        ? Text(
                            'COALESCE',
                            style: TextStyle(
                                color: Color(0xFF00C470),
                                fontSize: 45,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'COALESCE',
                            style: TextStyle(
                                color: Color(0xFF00C470),
                                fontSize: 45,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    width: _size.width * 0.88,
                    height: _size.height,
                    left: _isShowSignUp ? -_size.width * 0.76 : _size.width * 0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: updateView,
                      child: Container(
                        color: secondary,
                        child: loginForm(),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                      duration: defaultDuration,
                      width: _size.width * 0.88,
                      height: _size.height,
                      left: _isShowSignUp
                          ? _size.width * 0.12
                          : _size.width * 0.88,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: updateView,
                        child: Container(
                          color: primary,
                          child: signUpForm(),
                        ),
                      )),
                  AnimatedPositioned(
                      duration: defaultDuration,
                      bottom:
                          _isShowSignUp ? _size.height / 2 : _size.height * 0.3,
                      left: _isShowSignUp ? 0 : _size.width * 0.44 - 80,
                      child: AnimatedDefaultTextStyle(
                          duration: defaultDuration,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: _isShowSignUp ? 20 : 32,
                            fontWeight: FontWeight.bold,
                            color:
                                _isShowSignUp ? Colors.white : Colors.white70,
                          ),
                          child: Transform.rotate(
                            angle: -_animationTextRotate.value * pi / 180,
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                logIn(loginEmailController.text,
                                    loginPasswordController.text);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding * 0.75),
                                width: 160,
                                child: Text('LOG IN',
                                    style: TextStyle(color: golden)),
                              ),
                            ),
                          ))),
                  AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: !_isShowSignUp
                          ? _size.height / 2
                          : _size.height * 0.1,
                      right: _isShowSignUp ? _size.width * 0.44 - 80 : 0,
                      child: AnimatedDefaultTextStyle(
                          duration: defaultDuration,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: !_isShowSignUp ? 20 : 32,
                            fontWeight: FontWeight.bold,
                            color:
                                !_isShowSignUp ? Colors.white : Colors.white70,
                          ),
                          child: Transform.rotate(
                            angle: (90 - _animationTextRotate.value) * pi / 180,
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                signUp(
                                    signupNameController.text,
                                    signupEmailController.text,
                                    signupPhoneNoController.text,
                                    signupPasswordController.text,
                                    signupPasswordcController.text);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding * 0.75),
                                width: 160,
                                child: Text('SIGN UP',
                                    style: TextStyle(color: white)),
                              ),
                            ),
                          )))
                ],
              );
            }),
      ),
    );
  }

  //Login Section

  Container loginForm() {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Text(
              'COALESCE',
              style: TextStyle(
                  color: golden, fontSize: 45, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: loginTextEmail("Email", Icons.email),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: loginTextPassword("Password", Icons.lock),
            ),
            //
            //Forgot password section
            //
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     "Forgot Password?",
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
            SizedBox(
              height: 0.0,
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    ));
  }

  //Login Function
  logIn(String email, password) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            // builder: (BuildContext context) => MainPage()),
            builder: (BuildContext context) => Approval()),
        (Route<dynamic> route) => false);
    // try {
    //   _isLoading = true;
    //   Map<String, String> data = {"email": email, "password": password};
    //   Map<String, String> header = {
    //     "Accept": "application/json",
    //   };
    //   var jsonData = null;

    //   var response = await http.post(Uri.parse(url + "/login"),
    //       body: data, headers: header);
    //   jsonData = json.decode(response.body);
    //   if (email == '' || password == '') {
    //     snackBar("Fields cannot be left blank");
    //     _isLoading = false;
    //     setState(() {});
    //   } else {
    //     if (response.statusCode != 200) {
    //       snackBar("Wrong credentials or account doesnt exist");
    //       _isLoading = false;
    //       setState(() {});
    //     } else {
    //       snackBar(
    //           "Successfully Logged In ${intl.toBeginningOfSentenceCase(jsonData['username'])}");
    //       setState(() async {
    //         _isLoading = false;
    //         // SharedPreferences.setMockInitialValues({});
    //         SharedPreferences sharedPreferences =
    //             await SharedPreferences.getInstance();
    //         sharedPreferences.setString("token", jsonData['access_token']);
    //         sharedPreferences.setString('user_data_name', jsonData['username']);
    //         sharedPreferences.setString('user_data_email', jsonData['email']);
    //         sharedPreferences.setString(
    //             'user_data_phone_number', jsonData['phone_number']);
    //         // Navigator.of(context).pushAndRemoveUntil(
    //         //     MaterialPageRoute(
    //         //         // builder: (BuildContext context) => MainPage()),
    //         //         builder: (BuildContext context) => MainArrange()),
    //         //     (Route<dynamic> route) => false);
    //       });
    //     }
    //   }
    // } on Exception catch (e) {
    //   snackBar("Something went Wrong");
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }

//Signup section
  Container signUpForm() {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13),
      child: Form(
        child: Column(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: signupTextName("Name", Icons.email),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: signupTextEmail("Email", Icons.email),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: signupPhoneNo("Phone Number", Icons.email),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: signupTextPassword("Password", Icons.email),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: signupTextPasswordc("Password Confirmation", Icons.email),
            ),
            Spacer(flex: 2)
          ],
        ),
      ),
    ));
  }

  //Signup Function
  signUp(String name, email, phoneno, password, passwordc) async {
    try {
      _isLoading = false;
      Map<String, String> data = {
        "email": email,
        "name": name,
        "phone_number": phoneno,
        "password": password,
        "password_confirmation": passwordc
      };
      Map<String, String> header = {
        "Accept": "application/json",
      };
      var jsonData = null;
      var errors;
      var response = await http.post(Uri.parse(url + "/signup"),
          body: data, headers: header);
      jsonData = json.decode(response.body);

      print("object");

      if (email == '' ||
          name == '' ||
          phoneno == '' ||
          password == '' ||
          passwordc == '') {
        snackBar("Fields cannot be left blank");
        _isLoading = false;
        setState(() {});
      } else {
        if (response.statusCode != 201) {
          errors = jsonDecode(jsonEncode(jsonData["errors"]));
          print(errors);
          if (errors["name"].toString() != 'null') {
            snackBar("Name Invalid");
          }
          if (errors["email"].toString() != 'null') {
            snackBar(errors["email"]
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', ''));
          }
          if (errors["phone_number"].toString() != 'null') {
            snackBar("Phone Number Invalid");
          }
          if (errors["password"].toString() != 'null') {
            snackBar(errors["password"]
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', ''));
          }
          _isLoading = false;
          setState(() {});
        } else {
          snackBar(
              "Successfully registered ${intl.toBeginningOfSentenceCase(signupNameController.text)}");
          setState(() {
            _isLoading = false;
            updateView();
          });
        }
      }
    } on Exception catch (e) {
      snackBar("Something went Wrong");
      setState(() {
        _isLoading = false;
      });
    }
  }

//Login Form Controller Logic
  TextFormField loginTextEmail(String title, IconData icon) {
    return TextFormField(
        controller: loginEmailController,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: greyish, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: greyish, width: 2.0),
          ),
          labelText: title,
          labelStyle:
              TextStyle(color: myFocusNode.hasFocus ? Colors.black : greyish),
          hintText: "Enter valid mail id",
          hintStyle:
              TextStyle(color: myFocusNode.hasFocus ? Colors.grey : greyish),
        ));
  }

  TextFormField loginTextPassword(String title, IconData icon) {
    return TextFormField(
        controller: loginPasswordController,
        obscureText: true,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: greyish, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: greyish, width: 2.0),
          ),
          labelText: title,
          labelStyle:
              TextStyle(color: myFocusNode.hasFocus ? Colors.black : greyish),
          hintText: "Enter valid password",
          hintStyle:
              TextStyle(color: myFocusNode.hasFocus ? Colors.grey : greyish),
        ));
  }

  //Signup Form Controller Logic
  TextFormField signupTextName(String title, IconData icon) {
    return TextFormField(
        controller: signupNameController,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          labelText: title,
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.black : Colors.white70),
          hintText: "Enter valid name",
          hintStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.grey : Colors.white70),
        ));
  }

  TextFormField signupTextEmail(String title, IconData icon) {
    return TextFormField(
        controller: signupEmailController,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          labelText: title,
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.black : Colors.white70),
          hintText: "Enter valid email id",
          hintStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.grey : Colors.white70),
        ));
  }

  TextFormField signupTextPassword(String title, IconData icon) {
    return TextFormField(
        controller: signupPasswordController,
        obscureText: true,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          labelText: title,
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.black : Colors.white70),
          hintText: "Enter valid password",
          hintStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.grey : Colors.white70),
        ));
  }

  TextFormField signupTextPasswordc(String title, IconData icon) {
    return TextFormField(
        controller: signupPasswordcController,
        obscureText: true,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          labelText: title,
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.black : Colors.white70),
          hintText: "Enter valid password",
          hintStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.grey : Colors.white70),
        ));
  }

  TextFormField signupPhoneNo(String title, IconData icon) {
    return TextFormField(
        controller: signupPhoneNoController,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          labelText: title,
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.black : Colors.white70),
          hintText: "Enter valid phone number",
          hintStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.grey : Colors.white70),
        ));
  }

  //Snackbar
  snackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
