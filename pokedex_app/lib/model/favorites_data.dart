import 'dart:convert';

FavoriteData favoriteDataFromJson(String str) =>
    FavoriteData.fromJson(json.decode(str));

class FavoriteData {
  FavoriteData({required this.favorites});
  List<String> favorites;

  factory FavoriteData.fromJson(Map<String, dynamic> json) {
    var dataFav = json["favorites"];

    return FavoriteData(favorites: dataFav);
  }

  factory FavoriteData.fromString(String data) {
    var decodedData = jsonDecode(data);
    var value = jsonDecode(decodedData["favorites"]);
    return FavoriteData(favorites: List<String>.from(value));
  }

  Map<String, dynamic> toJson() => {'favorites': jsonEncode(favorites)};
}
