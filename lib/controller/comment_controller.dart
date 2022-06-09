import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone2/constant.dart';
import 'package:tiktok_clone2/model/comment.dart';

class CommentController extends GetxController {
  Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _videoId = "";
  updateVideoId(String postId) {
    _videoId = postId;
    getComments();
  }

  getComments() {
    _comments.bindStream(firestore
        .collection('videos')
        .doc(_videoId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<Comment> returnValue = [];
      for (var element in snapshot.docs) {
        returnValue.add(Comment.fromSnapshot(element));
      }
      return returnValue;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authController.user!.uid)
            .get();

        QuerySnapshot commentQuerySnapshot = await firestore
            .collection('videos')
            .doc(_videoId)
            .collection('comments')
            .get();

        int id = commentQuerySnapshot.docs.length;
        String commentId = 'comment $id';

        Comment comment = Comment(
            id: commentId,
            videoId: _videoId,
            uid: (userDoc.data() as Map<String, dynamic>)['uid'],
            username: (userDoc.data() as Map<String, dynamic>)['name'],
            profilePhoto:
                (userDoc.data() as Map<String, dynamic>)['profilePhoto'],
            comment: commentText.trim(),
            likes: [],
            dataPublished: DateTime.now());

        await firestore
            .collection('videos')
            .doc(_videoId)
            .collection('comments')
            .doc(commentId)
            .set(comment.toJason());
      } else {
        Get.snackbar('Posting Error', 'fill up all fields');
      }
    } catch (e) {
      Get.snackbar('Posting Error', e.toString());
      print(e.toString());
    }
  }

  postLike(String commentId) async {
    DocumentSnapshot doc = await firestore
        .collection('videos')
        .doc(_videoId)
        .collection('comments')
        .doc(commentId)
        .get();
    final likes = (doc.data() as dynamic)['likes'];
    if (likes.contains(authController.user!.uid)) {
      await firestore
          .collection('videos')
          .doc(_videoId)
          .collection('comments')
          .doc(commentId)
          .update({
        'likes': FieldValue.arrayRemove([authController.user!.uid]),
      });
    } else {
      await firestore
          .collection('videos')
          .doc(_videoId)
          .collection('comments')
          .doc(commentId)
          .update({
        'likes': FieldValue.arrayUnion([authController.user!.uid]),
      });
    }
  }
}
