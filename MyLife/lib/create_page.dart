import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_adder/post.dart';
import 'package:path/path.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class CreatePage extends StatefulWidget {
  Box boxReference;
  int? index;
  File? intentImage;
  VoidCallback updateParentState;
  CreatePage(
      {super.key,
      required this.boxReference,
      this.index,
      this.intentImage,
      required this.updateParentState});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController captionController = TextEditingController();
  String? fileNameGlobal;
  PostModel? post;

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      post = widget.boxReference.getAt(widget.index!);
      if (post != null) {
        captionController.text = post!.caption!;
        fileNameGlobal = post!.imagePath;
      }
    }
    ReceiveSharingIntent.getInitialMedia()
        .then((value) => value.forEach((element) {
              //File imageFile = File(element.path);
              print("Intent received");
            }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: "Create Post",
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 70, 193, 241),
            title: const Text(
              "Create post",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration:  InputDecoration(
                    hintText: "What's in my mind ?",
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide:const  BorderSide(width: 1, color: Colors.blue),
                      borderRadius:BorderRadius.circular(15),
                    ),
                  ),
                  controller: captionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 3,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 87, 209, 234),
                            minimumSize: const Size(10, 40)),
                        child: const Icon(Icons.photo_camera),
                        onPressed: () async {
                          //  _askCameraAccess(context);
                          XFile? imageXFile = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (imageXFile == null) return;
                          File imageFile = File(imageXFile.path);
                          _handleImage(imageFile);
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 87, 209, 234),
                              minimumSize: const Size(10, 40)),
                          child: const Icon(Icons.image),
                          onPressed: () async {
                            //    _getFromGallery(context);
                            XFile? imageXFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (imageXFile == null) return;
                            File? imageFile = File(imageXFile.path);
                            _handleImage(imageFile);
                          }),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:const Color.fromARGB(255, 87, 209, 234),
                        elevation: 5,
                        minimumSize: const Size(80, 45)),
                    onPressed: () async {
                      if (captionController.text != "" ||
                          fileNameGlobal != null) {
                        if (captionController.text == "delete") {
                          await widget.boxReference
                              .deleteAll(widget.boxReference.keys);
                          captionController.clear();
                        } else {
                          String caption = captionController.text;
                          String createdAt = post != null
                              ? post!.createdAt!
                              : DateTime.now().toString();
                          PostModel model = PostModel(
                              caption: caption,
                              imagePath: fileNameGlobal,
                              createdAt: createdAt);
                          if (post != null) {
                            widget.boxReference.putAt(widget.index!, model);
                          } else {
                            widget.boxReference.add(model);
                          }
                          widget.updateParentState();
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text(
                      "post",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              fileNameGlobal != null
                  ? Image.file(File(fileNameGlobal!))
                  : const Text(''),
            ]),
          ),
        ));
  }

  void _handleImage(File? imageFile) async {
    if (imageFile == null) return;
    final String applicationFilePath = (await _getDirectory()).path;
    final String fileName = basename(imageFile.path);
    await FlutterImageCompress.compressAndGetFile(
        imageFile.path, '$applicationFilePath/$fileName',
        quality: 30);
    setState(() {
      fileNameGlobal = '$applicationFilePath/$fileName';
    });
  }

  Future<Directory> _getDirectory() async {
    const String pathExt = 'MyLife';
    String externalAppPath = '/storage/emulated/0/$pathExt';
    Directory externalAppDirectory = Directory(externalAppPath);
    if (await externalAppDirectory.exists() == false) {
      return externalAppDirectory.create(recursive: true);
    }
    return externalAppDirectory;
  }
}
