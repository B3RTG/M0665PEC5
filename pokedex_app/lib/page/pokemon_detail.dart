import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/model/pokemon.dart';
import 'package:pokedex_app/services/pokemon_services.dart';
import 'package:pokedex_app/widget/pokemon_detail_card.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name), centerTitle: true),
      body: FutureBuilder<PokemonDetail>(
        future: PokemonSerice().getPokemonDetail(pokemon.name),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var pokemonDetail = snapshot.data;
            if (pokemonDetail != null) {
              return PokemonDetailCard(
                pokemonDetail: pokemonDetail,
              );
            }
          } else if (snapshot.hasError) {
            return Column(
              children: <Widget>[
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

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
