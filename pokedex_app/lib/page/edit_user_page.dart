import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokedex_app/services/user_services.dart';
import 'package:pokedex_app/widget/navigation_drawer_widget.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  File? image;

  @override
  void initState() {
    super.initState();
    var user = UserApi().getCurrentUser();
    if (user.phothFromConfig) {
      image = File(user.photoUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Favoritos"), centerTitle: true),
        body: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const SizedBox(
                  height: 48,
                ),
                image != null
                    ? ClipOval(
                        child: Image.file(
                        image!,
                        width: 160,
                        height: 160,
                      ))
                    : const FlutterLogo(
                        size: 160,
                      ),
                const SizedBox(
                  height: 48,
                ),
                buildButton("Pick from galery", Icons.image,
                    () => pickImage(ImageSource.gallery)),
                const SizedBox(
                  height: 48,
                ),
                buildButton("Pick from camera", Icons.image,
                    () => pickImage(ImageSource.camera)),
              ],
            )));
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // final imageTemp = File(image.path);
      final imageFinal = await saveImageLocalStorage(image.path);
      //save to user preferences
      UserApi().saveUserProfilePhoto(imageFinal.path);
      setState(() {
        this.image = imageFinal;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveImageLocalStorage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File("${directory.path}/$name");

    return File(imagePath).copy(image.path);
  }

  Widget buildButton(String title, IconData icon, VoidCallback onClicked) =>
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              primary: Colors.blue,
              onPrimary: Colors.black,
              textStyle: const TextStyle(fontSize: 20)),
          onPressed: onClicked,
          child: Row(
            children: [
              Icon(
                icon,
                size: 28,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(title)
            ],
          ));
}
