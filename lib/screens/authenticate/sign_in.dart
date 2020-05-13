import 'package:doc_lock/services/auth.dart';
import 'package:doc_lock/shared/constants.dart';
import 'package:doc_lock/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  //class instance
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //textField state
  String email = '';
  String password = '';
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Existing Patients'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){
              widget.toggleView();
            },

          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
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
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      print('valid');
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState((){
                          error = "Email or Password is incorrect";
                          loading = false;
                        }); 
                      }
                    }

                },
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