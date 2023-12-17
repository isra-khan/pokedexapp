import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/cubit/favourite_state.dart';
import 'package:pokedex/cubit/pokemon__cubit.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this._preferences) : super(FavoriteState()) {
    fetchFavorites();
  }
  final SharedPreferences _preferences;
  FirebaseAuth auth = FirebaseAuth.instance;

  void toggleFavorite(Pokemon pokemonName) async {
    final newFavorites = List<Pokemon>.from(state.favorites);

    if (newFavorites.contains(pokemonName.name)) {
      newFavorites.remove(pokemonName);
    } else {
      final currentFavorites = state.favorites;
      final newFavorites = [...currentFavorites, pokemonName];
      newFavorites.add(pokemonName);
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
        // Fetch favorites for the current user from the database
        final String favoritesString =
            _preferences.getString('${currentUser!.uid}_favorites') ?? '';
        final List<dynamic> favoritesJson = json.decode(favoritesString);

        if (favoritesJson.isNotEmpty) {
          final List<Pokemon> favorites =
              favoritesJson.map((json) => Pokemon.fromJson(json)).toList();

          emit(FavoriteState(favorites: favorites));
        }
      } catch (error) {
        // Handle errors if needed
        print('Error fetching favorites: $error');
      }
    }
  }
}
