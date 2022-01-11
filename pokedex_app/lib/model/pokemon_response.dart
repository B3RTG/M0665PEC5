// To parse this JSON data, do
//
//     final pokemonResponse = pokemonResponseFromJson(jsonString);

import 'dart:convert';

import 'package:pokedex_app/model/pokemon.dart';

PokemonResponse pokemonResponseFromJson(String str) =>
    PokemonResponse.fromJson(json.decode(str));

String pokemonResponseToJson(PokemonResponse data) =>
    json.encode(data.toJson());

class PokemonResponse {
  PokemonResponse({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });

  int count;
  String next;
  String? previous;
  List<Pokemon> results;

  factory PokemonResponse.fromJson(Map<String, dynamic> json) =>
      PokemonResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Pokemon>.from(json["results"].map((x) => Pokemon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<Pokemon>.from(results.map((x) => x.toJson())),
      };
}
