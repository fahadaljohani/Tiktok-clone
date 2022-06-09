import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone2/constant.dart';
import 'package:tiktok_clone2/model/video.dart';

class VideoController extends GetxController {
  Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    _videoList.bindStream(firestore
        .collection('videos')
        .orderBy('publishedDate', descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Video> retValue = [];
      for (var element in querySnapshot.docs) {
        retValue.add(Video.fromSnapshot(element));
      }
      return retValue;
    }));
    super.onInit();
  }

  postLike(String videoId) async {
    DocumentSnapshot snapshot =
        await firestore.collection('videos').doc(videoId).get();
    final likes = (snapshot.data() as dynamic)['likes'];
    if (likes.contains(authController.user!.uid)) {
      await firestore.collection('videos').doc(videoId).update({
        'likes': FieldValue.arrayRemove([authController.user!.uid]),
      });
    } else {
      await firestore.collection('videos').doc(videoId).update({
        'likes': FieldValue.arrayUnion([authController.user!.uid]),
      });
    }
  }
}
