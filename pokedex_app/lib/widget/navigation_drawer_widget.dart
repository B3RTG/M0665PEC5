import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/model/user.dart';
import 'package:pokedex_app/page/about_page.dart';
import 'package:pokedex_app/page/dasboard_page.dart';
import 'package:pokedex_app/page/favorite_page.dart';
import 'package:pokedex_app/page/items_page.dart';
import 'package:pokedex_app/page/location_page.dart';
import 'package:pokedex_app/page/pokemon_page.dart';
import 'package:pokedex_app/page/user_page.dart';
import 'package:pokedex_app/widget/navigation_drawer_header.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key, required this.user})
      : super(key: key);

  final padding = const EdgeInsets.symmetric(horizontal: 10);
  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          padding: padding,
          children: <Widget>[
            NavigationDrawerHeader(
              user: user,
              onClicked: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserPage(
                          user: user,
                        )))
              },
              padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
            ),
            const SizedBox(
              height: 8,
            ),
            buildMenuItem(
              text: 'Dashboard',
              icon: Icons.dashboard,
              onClicked: () => selectedItemChanged(context, 0),
            ),
            const SizedBox(
              height: 8,
            ),
            buildMenuItem(
              text: 'Lista de pokemons',
              icon: Icons.catching_pokemon_outlined,
              onClicked: () => selectedItemChanged(context, 1),
            ),
            buildMenuItem(
              text: 'Favoritos',
              icon: Icons.favorite,
              onClicked: () => selectedItemChanged(context, 5),
            ),
            const SizedBox(
              height: 8,
            ),
            buildMenuItem(
              text: 'Localizaciones',
              icon: Icons.location_city_rounded,
              onClicked: () => selectedItemChanged(context, 2),
            ),
            const SizedBox(
              height: 8,
            ),
            buildMenuItem(
              text: 'Items',
              icon: Icons.emoji_objects_outlined,
              onClicked: () => selectedItemChanged(context, 3),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              color: Colors.white70,
            ),
            const SizedBox(
              height: 8,
            ),
            buildMenuItem(
              text: 'Acerca de',
              icon: Icons.help_outline_sharp,
              onClicked: () => selectedItemChanged(context, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  selectedItemChanged(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DashboardPage()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const PokemonPage()));
        break;
      case 2:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LocationPage()));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const ItemsPage()));
        break;
      case 4:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const AboutPage()));
        break;
      case 5:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const FavoritePage()));
        break;
    }
  }
}
