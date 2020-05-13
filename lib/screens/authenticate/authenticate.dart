import 'package:doc_lock/screens/authenticate/register.dart';
import 'package:doc_lock/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {

    if(showSignIn){
      return Register(toggleView: toggleView);
    } else {
      return SignIn(toggleView: toggleView);
    }
  }
}