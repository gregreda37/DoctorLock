import 'package:doc_lock/models/brew.dart';
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
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 60.0),
          child: Text("Bottom sheet"),
        );
      });
    }


    return StreamProvider<List <Brew>>.value(
        value: DatabaseService().brews, 
        child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Greg'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label:Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text("settings"),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}