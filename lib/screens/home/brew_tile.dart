import 'package:doc_lock/screens/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:doc_lock/models/patient.dart';

class BrewTile extends StatelessWidget {

  final Patient brew;
  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 60.0),
          child: SettingsForm(brew.uid),
        );
      });
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red[brew.severity],
          ),
          title: Text(brew.name),
          subtitle: Text("Pain Level 1-10 (${brew.pain})"),
          onTap: () {
            _showSettingsPanel();
          },
        ),
      ),
    );
  }
}