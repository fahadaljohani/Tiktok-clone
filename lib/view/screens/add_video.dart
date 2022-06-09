import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone2/constant.dart';
import 'confirm_screen.dart';
import 'dart:io';

class AddVideo extends StatelessWidget {
  // - properites
  const AddVideo({Key? key}) : super(key: key);

  // - methods
  pickImage(BuildContext context, ImageSource src) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              ConfirmScreen(videoFile: File(video.path), videoPath: video.path),
        ),
      );
    }
  }

  showDialogOption(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickImage(context, ImageSource.gallery),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text('Gallery'),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickImage(context, ImageSource.camera),
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text('camera'),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    children: [
                      Icon(Icons.cancel),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text('cancel'),
                      ),
                    ],
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => showDialogOption(context),
        child: Container(
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(7)),
          width: 190,
          height: 50,
          child: const Center(
            child: Text(
              'Add Video',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
