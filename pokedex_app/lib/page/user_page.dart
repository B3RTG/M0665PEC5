import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokedex_app/model/user.dart';
import 'package:pokedex_app/page/edit_user_page.dart';
import 'package:pokedex_app/services/user_services.dart';
import 'package:pokedex_app/widget/navigation_drawer_widget.dart';

class UserPage extends StatelessWidget {
  final UserData user;
  File? fileImage;

  UserPage({Key? key, required this.user}) : super(key: key) {
    if (user.phothFromConfig) {
      fileImage = File(user.photoUrl);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      drawer: NavigationDrawerWidget(
        user: UserApi().getCurrentUser(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(user.name),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditUserPage())),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: createImageWidget(),
        //width: 100,
        //height: 100,
        // child: Image(
        //   image: FileImage(fileImage!),
        //   fit: BoxFit.cover,
        // ) //Column(children: [
        // if (fileImage != null)
        //ImageContainer(file: fileImage!),
        // if (fileImage == null)
        //   Image.network(
        //     user.photoUrl,
        //     width: double.infinity,
        //     //height: double.infinity,
        //     fit: BoxFit.cover,
        //   ),
        //]),
      ));

  Widget createImageWidget() {
    if (fileImage != null) {
      return Image(
        image: FileImage(fileImage!),
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        user.photoUrl,
        width: double.infinity,
        //height: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key, required this.file}) : super(key: key);
  final File file;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image(
        image: FileImage(file),
      ),
    );
  }
}
