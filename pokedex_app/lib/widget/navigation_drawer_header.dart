import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/model/user.dart';

class NavigationDrawerHeader extends StatelessWidget {
  final UserData user;
  final EdgeInsetsGeometry padding;
  final VoidCallback onClicked;
  File? fileImage;

  NavigationDrawerHeader(
      {Key? key,
      required this.user,
      required this.onClicked,
      required this.padding})
      : super(key: key) {
    if (user.phothFromConfig) {
      fileImage = File(user.photoUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: padding,
        child: Row(
          children: [
            if (fileImage == null)
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.photoUrl),
              ),
            if (fileImage != null)
              CircleAvatar(
                radius: 30,
                backgroundImage: FileImage(fileImage!),
              ),
            //   ClipOval(
            //       child: Image.file(
            //     fileImage!,
            //     width: 90,
            //     height: 90,
            //   )),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  user.email,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
