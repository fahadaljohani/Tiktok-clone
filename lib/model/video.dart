import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String uid;
  String id;
  String username;
  String caption;
  String songName;
  String profilePhoto;
  String videoUrl;
  String thumbnail;
  int shareCount;
  int commentCount;
  List likes;
  final publishedDate;
  Video({
    required this.uid,
    required this.id,
    required this.username,
    required this.caption,
    required this.songName,
    required this.profilePhoto,
    required this.videoUrl,
    required this.thumbnail,
    required this.shareCount,
    required this.commentCount,
    required this.likes,
    required this.publishedDate,
  });

  Map<String, dynamic> toJason() => {
        'uid': uid,
        'id': id,
        'username': username,
        'caption': caption,
        'songName': songName,
        'profilePhoto': profilePhoto,
        'videoUrl': videoUrl,
        'thumbnail': thumbnail,
        'shareCount': shareCount,
        'commentCount': commentCount,
        'likes': likes,
        'publishedDate': publishedDate,
      };

  static Video fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return Video(
      uid: snap['uid'],
      id: snap['id'],
      username: snap['username'],
      caption: snap['caption'],
      songName: snap['songName'],
      profilePhoto: snap['profilePhoto'],
      videoUrl: snap['videoUrl'],
      thumbnail: snap['thumbnail'],
      shareCount: snap['shareCount'],
      commentCount: snap['commentCount'],
      likes: snap['likes'],
      publishedDate: snap['publishedDate'],
    );
  }
}
