import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone2/controller/search_controller.dart';
import 'package:tiktok_clone2/view/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  SearchController searchController = Get.put(SearchController());
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.grey[900], borderRadius: BorderRadius.circular(8)),
          child: TextField(
              autocorrect: false,
              controller: _controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: false,
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onSubmitted: (typedUser) {
                searchController.searchUser(typedUser);
              }),
        ),
      ),
      body: Obx(() {
        return ListView.builder(
            itemCount: searchController.searchedUser.length,
            itemBuilder: (context, index) {
              final user = searchController.searchedUser[index];
              return Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 20,
                            backgroundImage: NetworkImage(user.profilePhoto),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(uid: user.uid),
                              ),
                            ),
                            child: Text(
                              user.name,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
