import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constant.dart';
import 'package:tiktok_clone2/controller/video_controller.dart';
import 'package:tiktok_clone2/view/screens/comment_screen.dart';
import 'package:tiktok_clone2/view/widgets/circle_animation.dart';
import 'package:tiktok_clone2/view/widgets/show_icon.dart';
import 'package:tiktok_clone2/view/widgets/video_player_item.dart';
import 'package:get/get.dart';

class VideoScreen extends StatelessWidget {
  // - Properties
  final VideoController videoController = Get.put(VideoController());
  VideoScreen({Key? key}) : super(key: key);

  // - helper methods
  albumMusic(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.grey, Colors.white]),
          borderRadius: BorderRadius.circular(30),
        ),
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(11),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image(
              image: NetworkImage(profilePhoto),
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Center(
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(1),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Positioned(
          //   left: 15,
          //   bottom: -1,
          //   child: Icon(
          //     Icons.add,
          //     color: Colors.white,
          //     size: 20,
          //   ),
          // )
        ]),
      ),
    );
  }

  // - Build Methods
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemCount: videoController.videoList.length,
            itemBuilder: (context, index) {
              final data = videoController.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItem(videoUrl: data.videoUrl),
                  Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '@ ${data.username} ',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      data.caption,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.music_note),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          data.songName,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  buildProfile(data.profilePhoto),
                                  ShowIcon(
                                      onTap: () =>
                                          videoController.postLike(data.id),
                                      iconData: data.likes.contains(
                                              authController.user!.uid)
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      content: data.likes.length.toString(),
                                      color: data.likes.contains(
                                              authController.user!.uid)
                                          ? Colors.red
                                          : Colors.white),
                                  ShowIcon(
                                      onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CommentScreen(
                                                      videoId: data.id),
                                            ),
                                          ),
                                      iconData: Icons.comment,
                                      content: data.commentCount.toString(),
                                      color: Colors.white),
                                  ShowIcon(
                                      onTap: () {},
                                      iconData: Icons.reply,
                                      content: data.shareCount.toString(),
                                      color: Colors.white),
                                  CircleAnimation(
                                      child: albumMusic(data.profilePhoto)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            });
      }),
    );
  }
}
