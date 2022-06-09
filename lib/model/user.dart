import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String uid;
  String profilePhoto;
  User(
      {required this.name,
      required this.email,
      required this.uid,
      required this.profilePhoto});

  Map<String, dynamic> toJason() =>
      {'name': name, 'email': email, 'uid': uid, 'profilePhoto': profilePhoto};

  static User fromSnap(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return User(
        name: snap['name'],
        email: snap['email'],
        uid: snap['uid'],
        profilePhoto: snap['profilePhoto']);
  }
}
