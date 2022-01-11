import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:pokedex_app/model/favorites_data.dart';
import 'package:pokedex_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  /// Singleton pattern used here.
  static final UserApi _userApi = UserApi._internal();

  static const String favoritesKey = "favorite";
  static const String photoPathKey = "photo";

  factory UserApi() {
    return _userApi;
  }

  UserApi._internal();

  UserData getCurrentUser() {
    final currentUser = UserData("Albert", "al6ertgarcia@uoc.edu",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Cara_Delevingne_by_Gage_Skidmore.jpg/800px-Cara_Delevingne_by_Gage_Skidmore.jpg");
    String? value = GetStorage().read(photoPathKey);
    if (value != null && value != "") {
      currentUser.photoUrl = value;
      currentUser.phothFromConfig = true;
    }
    return currentUser;
  }

  Future<bool> writeUserSharedPreferences(String key, String value) async {
    var sp = await SharedPreferences.getInstance();
    return await sp.setString(key, value);
  }

  Future<String> readUserSharedPreferences(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getString(key) ?? "";
  }

  Future<List<String>> getFavoritePokemons() async {
    var sp = await readUserSharedPreferences(favoritesKey);
    FavoriteData favoriteData;
    if (sp == "") {
      // no saved data, create
      favoriteData = FavoriteData(favorites: <String>[]);
    } else {
      //we got data, add
      favoriteData = FavoriteData.fromString(sp);
    }
    return favoriteData.favorites;
  }

  Future<bool> addPokemonToFavorites(String pokemonName) async {
    var sp = await readUserSharedPreferences(favoritesKey);
    FavoriteData favoriteData;
    if (sp == "") {
      // no saved data, create
      favoriteData = FavoriteData(favorites: <String>[]);
    } else {
      //we got data, add
      favoriteData = FavoriteData.fromString(sp);
    }
    favoriteData.favorites.add(pokemonName);

    return await writeUserSharedPreferences(
        favoritesKey, jsonEncode(favoriteData));
  }

  Future<bool> removePokemonToFavorites(String pokemonName) async {
    var sp = await readUserSharedPreferences(favoritesKey);
    FavoriteData favoriteData;
    if (sp == "") {
      // no saved data, create
      return true;
    } else {
      //we got data, add
      favoriteData = FavoriteData.fromString(sp);
    }
    favoriteData.favorites.remove(pokemonName);

    return await writeUserSharedPreferences(
        favoritesKey, jsonEncode(favoriteData));
  }

  Future<bool> saveUserProfilePhoto(String path) async {
    GetStorage().write(photoPathKey, path);
    return await writeUserSharedPreferences(photoPathKey, path);
  }

  Future<String> getUserProfilePhotoPath() async {
    return await readUserSharedPreferences(photoPathKey);
  }
}
