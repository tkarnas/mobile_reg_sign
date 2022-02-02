import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kodelab/models/user.dart';
import 'package:kodelab/models/user_list.dart';
import 'package:kodelab/screens/home/user_list.dart';
import 'package:kodelab/services/auth.dart';
import 'package:kodelab/services/database.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final Userr user;
  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: Row(children: <Widget>[
          Expanded(
            child: ListTile(
              title: Text('${user.firstName} ${user.lastName}'),
              subtitle: Text(user.sex == 1
                  ? '${user.email}\nSpol: Muško\nStručna sprema: ${user.qualification}'
                  : '${user.email}\nSpol: Žensko\nStručna sprema: ${user.qualification}'),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 5.0),
            child: RaisedButton(
              color: Colors.red[300],
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // AuthService().deleteUser(user.uid);
                DatabaseService().deleteUser(user.uid);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
