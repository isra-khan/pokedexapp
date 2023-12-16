// favorite_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/cubit/favourite_state.dart';
import 'package:pokedex/models/pokemon_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());

  void toggleFavorite(Pokemon pokemonName) {
    final newFavorites = List<Pokemon>.from(state.favorites);

    if (newFavorites.contains(pokemonName.name)) {
      newFavorites.remove(pokemonName);
    } else {
      newFavorites.add(pokemonName);
    }

    emit(state.copyWith(favorites: newFavorites));
  }
}
