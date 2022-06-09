import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone2/constant.dart';
import 'package:tiktok_clone2/controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  String uid;
  ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    profileController.updateUserUid(widget.uid);
    super.initState();
  }

  Column userData(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return controller.userInfo.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black54,
                    leading: const Icon(Icons.person_add_alt_1_outlined),
                    title: Text(
                      controller.userInfo['username'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                    actions: [
                      Icon(Icons.more_horiz),
                    ],
                  ),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      height: 100,
                                      width: 100,
                                      imageUrl:
                                          controller.userInfo['profilePhoto'],
                                      fit: BoxFit.cover,
                                      placeholder: (context, imageUrl) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, imageUrl, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  userData(controller.userInfo['followers'],
                                      'followers'),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    width: 1,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54),
                                  ),
                                  userData(controller.userInfo['following'],
                                      'following'),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    width: 1,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54),
                                  ),
                                  userData(profileController.userInfo['likes'],
                                      'likes'),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  if (authController.user!.uid == widget.uid) {
                                    authController.signOut();
                                  } else {
                                    if (controller.userInfo['isFollowing']) {}
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    authController.user!.uid == widget.uid
                                        ? 'Sign out'
                                        : controller.userInfo['isFollowing']
                                            ? 'unfollow'
                                            : 'follow',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 30,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (profileController
                                      .userInfo['thumbnail'] as List)
                                  .length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 5,
                                      childAspectRatio: 1,
                                      mainAxisSpacing: 5,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: controller.userInfo['thumbnail']
                                        [index]);
                              }),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
