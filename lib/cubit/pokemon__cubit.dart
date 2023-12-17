import 'package:pokedex/cubit/favourite_cubit.dart';
import 'package:pokedex/cubit/pokemon_state.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/repositories/pokemon_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
class ToggleFavorite extends PokemonListEvent {
  final int pokemonId;

  ToggleFavorite({required this.pokemonId});

  @override
  List<Object?> get props => [pokemonId];
}

class FetchFavorites extends PokemonListEvent {}

// Cubit
class PokemonListCubit extends Cubit<PokemonListState> {
  final PokemonRepository _repository = PokemonRepository();
  List<Pokemon> _favoritePokemonList = [];
  final FavoriteCubit? favoriteCubit;

  PokemonListCubit({this.favoriteCubit}) : super(PokemonListInitial());

  List<Pokemon> getFavoritePokemonList() {
    return _favoritePokemonList;
  }

  void toggleFavorite(int pokemonId) {
    final currentState = state;
    if (currentState is PokemonListLoaded) {
      final updatedPokemonList = currentState.pokemonList
          .map((pokemon) => pokemon.id == pokemonId
              ? pokemon.copyWith(isFavorite: !pokemon.isFavorite)
              : pokemon)
          .toList();
      emit(PokemonListLoaded(pokemonList: updatedPokemonList));

      _favoritePokemonList =
          updatedPokemonList.where((pokemon) => pokemon.isFavorite).toList();
    }
  }

  void fetchFavorites() {
    emit(PokemonListFavorites(favoritePokemonList: _favoritePokemonList));
  }

  void fetchPokemonList() async {
    try {
      emit(PokemonListLoading());

      final pokemonList = await _repository.fetchPokemonList();

      emit(PokemonListLoaded(pokemonList: pokemonList));
    } catch (e) {
      emit(PokemonListError(errorMessage: 'Failed to fetch Pokemon list'));
    }
  }
}
