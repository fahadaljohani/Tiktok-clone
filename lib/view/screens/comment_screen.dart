import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constant.dart';
import 'package:tiktok_clone2/controller/comment_controller.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatefulWidget {
  String videoId;
  CommentScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _controller = TextEditingController();

  CommentController commentController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    updatePostId();
  }

  updatePostId() async {
    await commentController.updateVideoId(widget.videoId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return SingleChildScrollView(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 20,
                              backgroundImage:
                                  NetworkImage(comment.profilePhoto),
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '@ ${comment.username}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  comment.comment,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  maxLines: 3,
                                )
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  timeago
                                      .format(comment.dataPublished.toDate()),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${comment.likes.length.toString()} like',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                            trailing: InkWell(
                              onTap: () =>
                                  commentController.postLike(comment.id),
                              child: Icon(
                                comment.likes.contains(authController.user!.uid)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: comment.likes
                                        .contains(authController.user!.uid)
                                    ? Colors.red
                                    : Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        );
                      });
                }),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _controller,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    commentController.postComment(_controller.text);
                    _controller.clear();
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
