import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/models/pokemon_model.dart';

// Events
abstract class PokemonListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPokemonList extends PokemonListEvent {}

class ToggleFavorite extends PokemonListEvent {
  final int pokemonId;

  ToggleFavorite({required this.pokemonId});

  @override
  List<Object?> get props => [pokemonId];
}

// States
abstract class PokemonListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {}

class PokemonListLoaded extends PokemonListState {
  final List<Pokemon> pokemonList;

  PokemonListLoaded({required this.pokemonList});

  @override
  List<Object?> get props => [pokemonList];
}

class FavouriteListLoaded extends PokemonListState {
  final List<Pokemon> favPokemonList;

  FavouriteListLoaded({required this.favPokemonList});

  @override
  List<Object?> get props => [favPokemonList];
}

class PokemonListError extends PokemonListState {
  final String errorMessage;

  PokemonListError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
