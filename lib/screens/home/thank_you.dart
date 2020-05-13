import 'package:doc_lock/screens/authenticate/authenticate.dart';
import 'package:doc_lock/services/auth.dart';
import 'package:flutter/material.dart';

class ThankYou extends StatelessWidget {
  
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            Text(
              "Thank You For Registering. Please take a seat",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                fontSize: 25,
                
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.white,
                child: Text(
                  'Return',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
          ],
          
        ),
      ),
    );
  }
}