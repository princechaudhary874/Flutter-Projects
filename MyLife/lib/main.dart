import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:post_adder/create_page.dart';
import 'package:post_adder/list_tiles.dart';
import 'package:post_adder/post.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PostModelAdapter());
  final box = await Hive.openBox('myposts');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController captionController = TextEditingController();
  List<dynamic> postList = [];
  Box box = Hive.box('myposts');
  File? selectedImage;
  File? intentImage;
  String? filenameGlobal;

  @override
  void initState() {
    postList = box.values.toList();
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 70, 193, 241),
        title: const Text("My Life",style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w500
        ),),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        child: ListView(children: [
          SizedBox(
            height: 55,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatePage(
                            boxReference: box,
                            updateParentState: updateParentState)));
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15)))),
              child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "What's in my mind ?",
                    style: TextStyle(color: Colors.cyan, fontSize: 16),
                  )),
            ),
          ),
          (postList.isEmpty)
              ? Container(
                  margin: const EdgeInsets.only(top: 200),
                  child: const Text(
                    "Start Creating Posts !",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                )
              : ListTiles(
                  listOfPosts: postList.reversed.toList(),
                  boxReference: box,
                  updateParentState: updateParentState,
                ),

          //(

          // children: [
          //   for (PostModel model in postList.reversed)
          //     ListTiles(post: model)
          // ],
          //),
        ]),
      ),
    );
  }

  void _handleImage(File? imageFile) async {
    print('Camera Status ${await Permission.camera.isGranted}');
    if (imageFile == null) return;
    final String applicationFilePath = (await _getDirectory()).path;
    final String fileName = basename(imageFile.path);
    await FlutterImageCompress.compressAndGetFile(
        imageFile.path, '$applicationFilePath/$fileName',
        quality: 30);
    setState(() {
      selectedImage = imageFile;
      filenameGlobal = '$applicationFilePath/$fileName';
    });
  }

  void _askCameraAccess() async {
    Permission cameraPermission = Permission.camera;
    if (await cameraPermission.isDenied) {
      await cameraPermission.request();
    }
  }

  Future<Directory> _getDirectory() async {
    const String pathExt = 'MyLife';
    String externalAppPath = '/storage/emulated/0/' + pathExt;
    Directory externalAppDirectory = Directory(externalAppPath);
    if (await externalAppDirectory.exists() == false) {
      return externalAppDirectory.create(recursive: true);
    }
    return externalAppDirectory;
  }

  void getPermission() async {
    Permission externalStoragePermission = Permission.manageExternalStorage;
    if (await externalStoragePermission.isDenied) {
      await externalStoragePermission.request();
    }
  }

  void updateParentState() {
    setState(() {
      postList = box.values.toList();
    });
  }
}
