import 'package:doc_lock/shared/constants.dart';
import 'package:doc_lock/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:doc_lock/services/auth.dart';
import 'package:doc_lock/services/database.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

    //class instance
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //textField state
  String email = '';
  String password = '';
  String name = '';
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
      return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('New Patient'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Returning Patients'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Name'),
                onChanged: (val){
                  setState(() => name = val);
                },
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Email'),
                validator: (val) => val.isEmpty ? 'Enter an Email': null,
                onChanged: (val){

                  setState(() => email = val);
                },
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter an Password 6+ characters long': null,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password, name);

                      if(result == null){
                        setState((){
                          error = "please supply a valid email";
                          loading = false;
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),
                
              )

            ],
          ),
        ),
      )
    );
  }
}