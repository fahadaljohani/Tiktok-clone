import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tiktok_clone2/controller/upload_controller.dart';
import 'package:tiktok_clone2/view/widgets/progres_dialog.dart';
import 'package:tiktok_clone2/view/widgets/textinput_field.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:get/get.dart';

class ConfirmScreen extends StatefulWidget {
  File videoFile;
  String videoPath;

  ConfirmScreen({Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController _videoPlayerController;
  final TextEditingController _songnameController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  bool isLoading = false;
  UploadVideoController uploadController = Get.put(UploadVideoController());
  @override
  void dispose() {
    _videoPlayerController.dispose();
    _songnameController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      _videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    _videoPlayerController.initialize();
    _videoPlayerController.play();
    _videoPlayerController.setVolume(1);
    _videoPlayerController.setLooping(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(_videoPlayerController),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextinputField(
                        controller: _songnameController,
                        labelText: 'Song name',
                        icon: Icons.music_note),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextinputField(
                        controller: _captionController,
                        labelText: 'Caption',
                        icon: Icons.closed_caption),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => const ProgressDialog(
                            message: 'Processing, Please wait...'),
                      );
                      await uploadController.uploadVideo(
                          _songnameController.text,
                          _captionController.text,
                          widget.videoPath);
                    },
                    child: const Text('Share'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        fixedSize: const Size(190, 50)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
