import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pokedex_app/model/pokemon.dart';
import 'package:pokedex_app/model/pokemon_response.dart';
import 'package:pokedex_app/page/pokemon_detail.dart';
import 'package:pokedex_app/services/pokemon_services.dart';
import 'package:pokedex_app/services/user_services.dart';
import 'package:pokedex_app/widget/navigation_drawer_widget.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final ScrollController _scrollController = ScrollController();
  late List<Pokemon> _pokemons;
  late String? _next;

  @override
  void initState() {
    super.initState();
    _pokemons = <Pokemon>[];
    _next = null;
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
      appBar: AppBar(title: const Text("Listado pokemons"), centerTitle: true),
      body: FutureBuilder<PokemonResponse>(
        future: PokemonSerice().getPokemonsResponseWithSprite(next: _next),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Pokemon> pokemons = snapshot.data!.results;
            _pokemons.addAll(pokemons);
            _next = snapshot.data!.next;

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
                          .addPokemonToFavorites(_pokemons[index].name)) {
                        var snackBar = SnackBar(
                          content: Text(
                              "Pokemon ${_pokemons[index].name} added to favorites correctly"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.favorite,
                    label: 'Favorite',
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
