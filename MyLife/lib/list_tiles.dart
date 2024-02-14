import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:post_adder/create_page.dart';

class ListTiles extends StatelessWidget {
  final List<dynamic> listOfPosts;
  final Box boxReference;
  final VoidCallback updateParentState;

  const ListTiles({
    Key? key,
    required this.listOfPosts,
    required this.boxReference,
    required this.updateParentState,
  }) : super(key: key);

  void deletePost(int index) async {
    int originalIndex = listOfPosts.length - 1 - index;
    boxReference.deleteAt(originalIndex);
    await File(listOfPosts[originalIndex].imagePath).delete();
  }

  @override
  Widget build(BuildContext context) {
    void editPost(int index) {
      int originalIndex = listOfPosts.length - 1 - index;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePage(
            boxReference: boxReference,
            updateParentState: updateParentState,
            index: originalIndex, // Pass original index
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: listOfPosts.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color:const Color.fromARGB(255, 101, 199, 238),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    listOfPosts[index].caption!,
                    style: const TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text("delete"),
                      onTap: () {
                        deletePost(index);
                        updateParentState();
                      },
                    ),
                    PopupMenuItem(
                      child: const Text("edit"),
                      onTap: () {
                        editPost(index);
                      },
                    ),
                  ],
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            Text(
              listOfPosts[index].createdAt!,
              style: const TextStyle(
                fontSize: 10,
                color: Color.fromARGB(255, 124, 104, 104),
              ),
            ),
            listOfPosts[index].imagePath != null
                ? Image.file(File(listOfPosts[index].imagePath!))
                : const Text(""),
          ],
        ),
      ),
    );
  }
}
