import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/services/user_services.dart';
import 'package:pokedex_app/widget/navigation_drawer_widget.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(
          user: UserApi().getCurrentUser(),
        ),
        appBar: AppBar(
          title: const Text("Listado localizaciones"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
      );
}
