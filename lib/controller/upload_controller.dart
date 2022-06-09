import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone2/constant.dart';
import 'package:tiktok_clone2/model/video.dart';
import 'package:tiktok_clone2/view/screens/home_screen.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  // - methods
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      if (songName.isNotEmpty && caption.isNotEmpty && videoPath.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authController.user!.uid)
            .get();
        final allDocs = await firestore.collection('videos').get();
        int len = allDocs.docs.length;
        String videoId = "video $len";
        String videoUrl = await _uploadVideoToStorage(videoId, videoPath);
        String thumbnail = await _uploadImageToStorage(videoId, videoPath);
        Video video = Video(
          uid: authController.user!.uid,
          id: videoId,
          username: (userDoc.data()! as dynamic)['name'],
          caption: caption,
          songName: songName,
          profilePhoto:
              (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          shareCount: 0,
          commentCount: 0,
          likes: [],
          publishedDate: DateTime.now(),
        );
        await firestore.collection('videos').doc(videoId).set(video.toJason());
        Get.offAll(HomeScreen());
      } else {
        Get.snackbar('Error uploading', 'fill up all fields.');
      }
    } catch (e) {
      Get.snackbar('Error uploading', e.toString(),
          duration: const Duration(seconds: 6));
    }
  }

  // - helper methods
  Future<String> _uploadVideoToStorage(String videoID, String videoPath) async {
    Reference reference = firebaseStorage.ref().child('videos').child(videoID);
    UploadTask uploadTask =
        reference.putFile(await _compressedVideo(videoPath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadVideoUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadVideoUrl;
  }

  _compressedVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  _uploadImageToStorage(String videoId, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(videoId);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }
}
