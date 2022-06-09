import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone2/view/screens/add_video.dart';
import 'package:tiktok_clone2/view/screens/search_screen.dart';
import 'package:tiktok_clone2/view/screens/video_screen.dart';
import 'package:tiktok_clone2/view/screens/profile_screen.dart';
import 'controller/auth_controller.dart';

// Color
const backgroundColor = Colors.black;
final buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// Firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

var authController = AuthController.instance;

// Screen pages
List page = [
  VideoScreen(),
  SearchScreen(),
  AddVideo(),
  const Center(child: Text('messaging')),
  ProfileScreen(uid: authController.user!.uid),
];
