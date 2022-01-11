//import 'package:http/http.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/model/pokemon.dart';
import 'package:pokedex_app/model/pokemon_response.dart';
import 'package:pokedex_app/services/user_services.dart';

class PokemonSerice {
  /// Singleton pattern used here.
  static final PokemonSerice _pokemonSerice = PokemonSerice._internal();

  factory PokemonSerice() {
    return _pokemonSerice;
  }

  PokemonSerice._internal();

  static const String _baseUrl = "pokeapi.co";
  static const String _apiRoot = "api/v2/";
  static const String _pokemonEntity = "pokemon";

  // void testingCall() async {
  //   var url = Uri.https("pokeapi.co", "api/v2/pokemon"); //, {'q': '{http}'}
  //   try {
  //     var response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       var jsonData = jsonDecode(response.body);
  //     } else {
  //       //petición incorrecta
  //     }
  //   } catch (err) {
  //     //handle error
  //   }
  // }

  // Future<List<Pokemon>> getPokemons() async {
  //   var url = Uri.https(_baseUrl, _apiRoot + _pokemonEntity);
  //   var completer = Completer<List<Pokemon>>();

  //   try {
  //     var response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       // PokemonResponse pokemonResponse =
  //       //     PokemonResponse.fromJson(jsonDecode(response.body));
  //       PokemonResponse pokemonResponse =
  //           pokemonResponseFromJson(response.body);
  //       completer.complete(pokemonResponse.results);
  //     } else {
  //       throw Exception('Unexpected error occured!');
  //     }
  //   } catch (err) {
  //     rethrow;
  //   }

  //   return completer.future;
  // }

  Future<List<Pokemon>> getPokemons({String? next}) async {
    var url = Uri.https(_baseUrl, _apiRoot + _pokemonEntity);
    if (next != null) {
      url = Uri.parse(next);
    }
    var response = await http.get(url);
    if (response.statusCode == 200) {
      PokemonResponse pokemonResponse = pokemonResponseFromJson(response.body);
      return pokemonResponse.results;
    } else {
      throw "Can't get pokemons";
    }
  }

  Future<PokemonResponse> getPokemonsResponse({String? next}) async {
    var url = Uri.https(_baseUrl, _apiRoot + _pokemonEntity);
    if (next != null) {
      url = Uri.parse(next);
    }
    var response = await http.get(url);
    if (response.statusCode == 200) {
      PokemonResponse pokemonResponse = pokemonResponseFromJson(response.body);
      return pokemonResponse;
    } else {
      throw "Can't get pokemons";
    }
  }

  Future<PokemonResponse> getPokemonsResponseWithSprite({String? next}) async {
    var url = Uri.https(_baseUrl, _apiRoot + _pokemonEntity);
    if (next != null) {
      url = Uri.parse(next);
    }

    var client = http.Client();

    var response = await client.get(url);
    if (response.statusCode == 200) {
      PokemonResponse pokemonResponse = pokemonResponseFromJson(response.body);

      for (var pokemon in pokemonResponse.results) {
        var urlDetail =
            Uri.https(_baseUrl, _apiRoot + _pokemonEntity + "/" + pokemon.name);
        var detailResponse = await client.get(urlDetail);
        if (detailResponse.statusCode == 200) {
          Pokemon pokemonDetail = pokemonFromJson(detailResponse.body);
          pokemon.sprite = pokemonDetail.sprite;
        }
      }

      return pokemonResponse;
    } else {
      throw "Can't get pokemons";
    }
  }

  Future<List<Pokemon>> getPokemonFromFavorites() async {
    List<Pokemon> result = <Pokemon>[];
    var names = await UserApi().getFavoritePokemons();

    if (names.isNotEmpty) {
      var client = http.Client();

      for (var name in names) {
        var url = Uri.https(_baseUrl, _apiRoot + _pokemonEntity + "/" + name);

        var detailResponse = await client.get(url);
        if (detailResponse.statusCode == 200) {
          Pokemon pokemon = pokemonFromJson(detailResponse.body);
          result.add(pokemon);
        }
      }
    }

    return result;
  }

  Future<PokemonDetail> getPokemonDetail(String name) async {
    var url = Uri.https(_baseUrl, _apiRoot + _pokemonEntity + "/" + name);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      PokemonDetail pokemon = pokemonDetailFromJson(response.body);
      return pokemon;
    } else {
      throw "Can't get pokemons";
    }
  }
}
