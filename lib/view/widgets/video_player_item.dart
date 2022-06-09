import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  String videoUrl;
  VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    videoPlayerController.initialize().then((value) {
      videoPlayerController.play();
      videoPlayerController.setVolume(1);
      videoPlayerController.setLooping(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      width: size.width,
      height: size.height,
      child: VideoPlayer(videoPlayerController),
    );
  }
}
