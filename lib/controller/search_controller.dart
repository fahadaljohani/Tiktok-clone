import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone2/constant.dart';
import 'package:tiktok_clone2/model/user.dart';

class SearchController extends GetxController {
  Rx<List<User>> _searchedUser = Rx<List<User>>([]);
  List<User> get searchedUser => _searchedUser.value;

  searchUser(String typedUser) {
    _searchedUser.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUser.trim())
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<User> returnValue = [];
      for (var doc in snapshot.docs) {
        returnValue.add(User.fromSnap(doc));
      }
      return returnValue;
    }));
  }
}
