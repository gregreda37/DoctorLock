import 'package:doc_lock/screens/authenticate/authenticate.dart';
import 'package:doc_lock/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doc_lock/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate
    final user = Provider.of<User>(context);
    
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}