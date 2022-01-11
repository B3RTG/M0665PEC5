import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pokedex_app/model/pokemon.dart';
import 'package:pokedex_app/model/pokemon_response.dart';
import 'package:pokedex_app/page/pokemon_detail.dart';
import 'package:pokedex_app/services/pokemon_services.dart';
import 'package:pokedex_app/services/user_services.dart';
import 'package:pokedex_app/widget/navigation_drawer_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoritePagetate();
}

class _FavoritePagetate extends State<FavoritePage> {
  final ScrollController _scrollController = ScrollController();
  late List<Pokemon> _pokemons;

  @override
  void initState() {
    super.initState();
    _pokemons = <Pokemon>[];
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        // we reach the end of the list, load new data
        // the api get us 20 items by 20
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(
        user: UserApi().getCurrentUser(),
      ),
      appBar: AppBar(title: const Text("Favoritos"), centerTitle: true),
      body: FutureBuilder<List<Pokemon>>(
        future: PokemonSerice().getPokemonFromFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _pokemons = snapshot.data!;

            return createList();
          } else if (snapshot.hasError) {
            return Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget createList() {
    return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        itemCount: _pokemons.length,
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      if (await UserApi()
                          .removePokemonToFavorites(_pokemons[index].name)) {
                        setState(() {});
                      }
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.remove_circle_outline,
                    label: 'Remove',
                  ),
                ],
              ),
              child: Card(
                  child: InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PokemonDetailPage(pokemon: _pokemons[index]))),
                splashColor: Colors.blue.withAlpha(30),
                child: Row(
                  children: [
                    Hero(
                        tag: _pokemons[index].name,
                        child: Image.network(
                            _pokemons[index].sprite!.frontDefault)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _pokemons[index].name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(_pokemons[index].url)
                        ]),
                  ],
                ),
              )));
        });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
