// class Pokemon {
//   final String name;
//   final String url;
//   String? imageUrl;

//   Pokemon(this.name, this.url);
// }

import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

class Pokemon {
  Pokemon({required this.name, required this.url, this.sprite});

  String name;
  String url;
  Sprite? sprite;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
      name: json["name"],
      url: json.containsKey("url") ? json["url"] : "",
      sprite: json.containsKey("sprites")
          ? Sprite.fromJson(json["sprites"])
          : Sprite(frontDefault: "", oficcialArtWork: ""));

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Sprite {
  String frontDefault;
  String oficcialArtWork;

  Sprite({required this.frontDefault, required this.oficcialArtWork});

  factory Sprite.fromJson(Map<String, dynamic> json) => Sprite(
      frontDefault: json["front_default"],
      oficcialArtWork: json["other"]["official-artwork"]["front_default"]);

  //Map<String, dynamic> toJson() => {"front_default": frontDefault};
}

PokemonDetail pokemonDetailFromJson(String str) =>
    PokemonDetail.fromJson(json.decode(str));

class PokemonDetail {
  PokemonDetail(
      {required this.name,
      required this.url,
      required this.sprite,
      required this.baseExperience,
      required this.height,
      required this.weight,
      required this.abilities,
      required this.types});

  String name;
  String url;
  Sprite sprite;
  int baseExperience;
  int height;
  int weight;
  List<Ability> abilities;
  List<PokemonType> types;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
        name: json["name"],
        url: json.containsKey("url") ? json["url"] : "",
        sprite: json.containsKey("sprites")
            ? Sprite.fromJson(json["sprites"])
            : Sprite(frontDefault: "", oficcialArtWork: ""),
        weight: json["weight"],
        baseExperience: json["base_experience"],
        height: json["height"],
        abilities: List<Ability>.from(
            json["abilities"].map((x) => Ability.fromJson(x))),
        types: List<PokemonType>.from(
            json["types"].map((x) => PokemonType.fromJson(x))));
    // List<Ability>.from(
    //     json["abilities"].map((x) => Ability.fromJson(x)))
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Ability {
  Ability({required this.name, required this.slot});

  String name;
  int slot;
  //int id;
  //, required this.id

  factory Ability.fromJson(Map<String, dynamic> json) =>
      Ability(name: json["ability"]["name"], slot: json["slot"]);
  //, id: json["id"]
}

class PokemonType {
  PokemonType({required this.name, required this.slot, required this.url});
  String name;
  String url;
  int slot;
  factory PokemonType.fromJson(Map<String, dynamic> json) => PokemonType(
      name: json["type"]["name"], slot: json["slot"], url: json["type"]["url"]);
}
