// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isChecked = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void _handleRemeberme(bool value) {
      print("Handle Rember Me");
      _isChecked = value;
      SharedPreferences.getInstance().then(
        (prefs) {
          prefs.setBool("remember_me", value);
          prefs.setString('email', _emailController.text);
          prefs.setString('password', _passwordController.text);
        },
      );
      setState(() {
        _isChecked = value;
      });
    }

    void _loadUserEmailPassword() async {
      print("Load Email");
      try {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        var _email = _prefs.getString("email") ?? "";
        var _password = _prefs.getString("password") ?? "";
        var _remeberMe = _prefs.getBool("remember_me") ?? false;

        print(_remeberMe);
        print(_email);
        print(_password);
        if (_remeberMe) {
          setState(() {
            _isChecked = true;
          });
          _emailController.text = _email ?? "";
          _passwordController.text = _password ?? "";
        }
      } catch (e) {
        print(e);
      }
    }

    @override
    void initState() {
      _loadUserEmailPassword();
      super.initState();
    }

    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      body: Container(
        padding: EdgeInsets.only(top: height / 19),
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                    height: height / 10,
                    width: width,
                    child: const Image(
                        image: AssetImage('assets/img/Logo/LogoLogin.png'))),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 10, left: 14),
              child: const Text(
                'Sign in',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                    color: Color(0XFF2F2F2F)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 7, left: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'EMAIL',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: Color(0XFF2F2F2F)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: width - 26,
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                            color: Color(0XFF2F2F2F)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'PASSWORD',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: Color(0XFF2F2F2F)),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    width: width - 26,
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                            color: Color(0XFF2F2F2F)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Theme(
                          data: ThemeData(
                              unselectedWidgetColor:
                                  Color(0xffA7ACB1) // Your color
                              ),
                          child: Checkbox(
                              activeColor: Color(0xffFFB7B4),
                              value: _isChecked,
                              onChanged: _handleRemeberme),
                        )),
                    const SizedBox(width: 10.0),
                    const Text("Remember Me",
                        style: TextStyle(
                            color: Color(0xff646464),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      width: width / 3.3,
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Color(0xff959595),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: height / 10,
                  ),
                  const Divider(
                    height: 10,
                    thickness: 2.0,
                    indent: 0,
                    endIndent: 14,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
