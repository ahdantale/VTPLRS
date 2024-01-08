import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'package:vtplrsapp/utilities/constant.dart';
import 'login_screen.dart';

class home_screen extends StatelessWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  "VTPLRS",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Bitter-Bold',
                      color: kAppColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonTheme(
                buttonColor: kButtonColor,
                minWidth: 252.0,
                height: 50.0,
                child: FlatButton(
                  color: kButtonColor,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UserLogin();
                    }));
                    print("pressed");
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 25,
                      color: kAppColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonTheme(
                minWidth: 253.0,
                height: 50.0,
                buttonColor: kButtonColor,
                child: FlatButton(
                  color: kButtonColor,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UserRegister();
                    }));
                    print("pressed");
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 25,
                      color: kAppColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
