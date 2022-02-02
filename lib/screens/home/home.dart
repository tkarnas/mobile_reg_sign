import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kodelab/models/user.dart';
import 'package:kodelab/models/user_list.dart';
import 'package:kodelab/screens/home/user_list.dart';
import 'package:kodelab/services/auth.dart';
import 'package:kodelab/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Userr>>.value(
        value: DatabaseService().users,
        child: Scaffold(
            backgroundColor: Colors.orange[50],
            appBar: AppBar(
              title: Text(
                'Kodelab',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.orange[400],
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Odjava'))
              ],
            ),
            body: UserList()));
  }
}
