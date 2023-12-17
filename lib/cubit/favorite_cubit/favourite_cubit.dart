import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:pokedex/cubit/favourite_state.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this._preferences) : super(FavoriteState()) {
    fetchFavorites();
  }
  final SharedPreferences _preferences;
  FirebaseAuth auth = FirebaseAuth.instance;

  void toggleFavorite(Pokemon pokemonName) async {
    final currentFavorites = state.favorites;
    final newFavorites = [...currentFavorites, pokemonName];

    if (newFavorites.contains(pokemonName.name)) {
      newFavorites.remove(pokemonName.id);
    } else {
      final String favoritesString =
          json.encode(newFavorites.map((p) => p.toJson()).toList());
      await _preferences.setString(
          '${auth.currentUser?.uid}_favorites', favoritesString);

      emit(state.copyWith(favorites: newFavorites));
    }
  }

  void fetchFavorites() async {
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      try {
        final String favoritesString =
            _preferences.getString('${currentUser!.uid}_favorites') ?? '';
        final List<dynamic> favoritesJson = json.decode(favoritesString);

        if (favoritesJson.isNotEmpty) {
          final List<Pokemon> favorites =
              favoritesJson.map((json) => Pokemon.fromJson(json)).toList();

          emit(FavoriteState(favorites: favorites));
        }
      } catch (error) {
        print('Error fetching favorites: $error');
      }
    }
  }
}
