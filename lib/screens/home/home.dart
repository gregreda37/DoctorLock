import 'package:doc_lock/models/patient.dart';

import 'package:doc_lock/services/database.dart';
import 'package:flutter/material.dart';
import 'package:doc_lock/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:doc_lock/screens/home/brew_list.dart';

//stles to create widget
class Home extends StatelessWidget {

final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List <Patient>>.value(
        value: DatabaseService().brews, 
        child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Doctor Portal'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label:Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}