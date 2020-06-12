import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_clone/models/user.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final Firestore _firestore = Firestore.instance;

  User user = User();

  Future<String> createUser(String email, String password, String name) async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;

    return user.uid;
  }
}