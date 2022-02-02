import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kodelab/models/user.dart';
import 'package:kodelab/models/user_list.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userColection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String firstName, String lastName, String email,
      int sex, String qualification) async {
    return await userColection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'sex': sex,
      'qualification': qualification
    });
  }

  Future<void> deleteUser(String uid) {
    return userColection.doc(uid).delete();
  }

  List<Userr> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Userr(
        uid: doc.id ?? '',
        firstName: doc.data()['firstName'] ?? '',
        lastName: doc.data()['lastName'] ?? '',
        email: doc.data()['email'] ?? '',
        sex: doc.data()['sex'] ?? 1,
        qualification: doc.data()['qualification'] ?? '',
      );
    }).toList();
  }

  Stream<List<Userr>> get users {
    return userColection.snapshots().map(_userListFromSnapshot);
  }
}
