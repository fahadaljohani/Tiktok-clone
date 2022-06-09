import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone2/constant.dart';

class ProfileController extends GetxController {
  Rx<String> _uid = ''.obs;
  Rx<Map<String, dynamic>> _userInfo = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get userInfo => _userInfo.value;
  updateUserUid(String id) {
    _uid.value = id;
    getUserDate();
  }

  getUserDate() async {
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    QuerySnapshot query = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();
    List<String> thumbnail = [];
    int likes = 0;
    for (var element in query.docs) {
      likes += ((element.data() as dynamic)['likes'] as List).length;
      thumbnail.add((element.data() as dynamic)['thumbnail']);
    }
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    QuerySnapshot followingQuery = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    QuerySnapshot followersQuery = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    following = followingQuery.docs.length;
    followers = followersQuery.docs.length;

    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _userInfo.value = {
      'username': (userDoc.data() as dynamic)['name'],
      'profilePhoto': (userDoc.data() as dynamic)['profilePhoto'],
      'likes': likes.toString(),
      'thumbnail': thumbnail,
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
    };
    update();
  }
}
