import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone2/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktok_clone2/model/user.dart' as model;
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone2/view/screens/auth/login_screen.dart';
import 'package:tiktok_clone2/view/screens/home_screen.dart';
import 'package:tiktok_clone2/view/screens/video_screen.dart';

class AuthController extends GetxController {
  // - properties
  static AuthController instance = Get.find();
  late Rx<File?> _pickedImage;
  late Rx<User?> _user;

  // - Getters
  File? get profileImage => _pickedImage.value;
  User? get user => _user.value;
  // - State
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, setInitialScreen);
  }

  void setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  // - methods
  Future<String> uploadImageToStorage(File profilePhoto, String uid) async {
    Reference reference =
        firebaseStorage.ref().child('ProfileImages').child(uid);
    UploadTask uploadTask = reference.putFile(profilePhoto);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Photo Gallery', 'did picked image successfully');
      _pickedImage = Rx<File?>(File(pickedImage.path));
    }
  }

  createUser(
      String name, String email, String password, File? profilePhoto) async {
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        profilePhoto != null) {
      try {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadPhotoUrl =
            await uploadImageToStorage(profilePhoto, cred.user!.uid);
        model.User user = model.User(
            name: name,
            email: email,
            uid: cred.user!.uid,
            profilePhoto: downloadPhotoUrl);
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJason());
        Get.snackbar('Creating Account', 'create user successfully.');
      } on FirebaseException catch (e) {
        Get.snackbar('Error Creating Account', e.message.toString());
      }
    } else {
      Get.snackbar('Error Creating Account', 'fill up all the fields.');
    }
  }

  login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        Get.snackbar('Login User', 'Login successfully.');
      } else {
        Get.snackbar('Error Login', 'fill up all the fields.');
      }
    } on FirebaseException catch (e) {
      Get.snackbar('Error login', e.message.toString());
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
}
