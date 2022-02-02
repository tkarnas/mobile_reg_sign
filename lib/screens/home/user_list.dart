import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kodelab/models/user.dart';
import 'package:kodelab/models/user_list.dart';
import 'package:kodelab/screens/home/user_tile.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Userr>>(context);

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(
          user: users[index],
        );
      },
    );
  }
}
