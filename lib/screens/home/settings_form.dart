import 'package:doc_lock/models/user.dart';
import 'package:doc_lock/services/database.dart';
import 'package:doc_lock/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:doc_lock/shared/constants.dart';


class SettingsForm extends StatefulWidget {
  final String uid;
  const SettingsForm(this.uid);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4','5','6','7','8','9','10'];
  
  String _currentSymptoms;
  String _currentPain;
  int _currentSeverity;
  String _name;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: widget.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Update Patient ${userData.name}",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.symptoms,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter patient symptoms' : null,
                  onChanged: (val) => setState(() => _currentSymptoms = val),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentPain ?? userData.pain,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar Pain'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentPain = val) ,
                ),
                Slider(
                  value: (_currentSeverity ?? userData.severity).toDouble(),
                  activeColor: Colors.red[_currentSeverity ?? userData.severity],
                  inactiveColor: Colors.red[_currentSeverity ?? userData.severity],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentSeverity = val.round()),

                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: widget.uid).updateUserData(
                        _currentPain ?? userData.pain,
                        _currentSymptoms ?? userData.symptoms,
                        _currentSeverity ?? userData.severity,
                        _name ?? userData.name,
                      );
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            )
        );
        } else {
          return Loading();
        }
      }
    );
  }
}