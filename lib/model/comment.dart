import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String videoId;
  String uid;
  String username;
  String profilePhoto;
  List likes;
  String comment;
  final dataPublished;

  Comment(
      {required this.id,
      required this.videoId,
      required this.uid,
      required this.username,
      required this.profilePhoto,
      required this.comment,
      required this.likes,
      required this.dataPublished});

  Map<String, dynamic> toJason() => {
        'id': id,
        'videoId': videoId,
        'uid': uid,
        'username': username,
        'profilePhoto': profilePhoto,
        'comment': comment,
        'likes': likes,
        'dataPublished': dataPublished,
      };
  static Comment fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return Comment(
      id: snap['id'],
      videoId: snap['videoId'],
      uid: snap['uid'],
      username: snap['username'],
      profilePhoto: snap['profilePhoto'],
      comment: snap['comment'],
      likes: snap['likes'],
      dataPublished: snap['dataPublished'],
    );
  }
}
