import 'package:flutter/material.dart';
import 'package:kodelab/services/auth.dart';
import 'package:kodelab/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String firstName = '';
  String lastName = '';
  String qualification = '';
  int sex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          elevation: 0.0,
          title: Text(
            'Registracijska forma',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text('Prijava'))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Ime'),
                    validator: (val) => val.isEmpty ? 'Unesite ime' : null,
                    onChanged: (val) {
                      setState(() {
                        firstName = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Prezime'),
                    validator: (val) => val.isEmpty ? 'Unesite prezime' : null,
                    onChanged: (val) {
                      setState(() {
                        lastName = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Unesite email' : null,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Lozinka'),
                    obscureText: true,
                    validator: (val) => val.length < 6
                        ? 'Unesite lozinku sa minimalno 6 znakova'
                        : null,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  DropdownButton(
                      value: sex,
                      items: [
                        DropdownMenuItem(
                          child: Text("Muško"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Žensko"),
                          value: 2,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          sex = value;
                        });
                      }),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Stručna sprema'),
                    validator: (val) =>
                        val.isEmpty ? 'Unesite stručnu spremu' : null,
                    onChanged: (val) {
                      setState(() {
                        qualification = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.orange[400],
                    child: Text(
                      'Registriraj me!',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result =
                            await _auth.registerWithEmailandPassword(firstName,
                                lastName, email, password, sex, qualification);
                        if (result == null) {
                          setState(() {
                            error = 'Molimo unesite odgovarajuči email!';
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(height: 12.0),
                  Text(error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0))
                ],
              ),
            ),
          ),
        ));
  }
}
