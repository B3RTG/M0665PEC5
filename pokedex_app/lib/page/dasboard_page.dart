import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/services/user_services.dart';
import 'package:pokedex_app/widget/navigation_drawer_widget.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);
  final user = UserApi().getCurrentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(
        user: user,
      ),
      appBar: AppBar(title: const Text("Dashboard"), centerTitle: true),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(Icons.menu)),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color(0xff7c94b6),
            image: DecorationImage(
              image: NetworkImage(
                  'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/87044f58-c765-43c5-bc51-8613e3ac7ab1/ddew4m7-c69a2c41-518f-48ca-ba35-8ab1895464e0.png'),
              fit: BoxFit.scaleDown,
            )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
          child: Column(children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 16),
            ),
            Text(user.name, style: const TextStyle(fontSize: 30))
          ]),
        ),
      ),
    );
  }
}
