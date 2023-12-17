import 'package:pokedex/models/pokemon_model.dart';
import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final List<Pokemon> favorites;

  const FavoriteState({List<Pokemon>? favorites})
      : this.favorites = favorites ?? const [];

  @override
  List<Object> get props => [favorites];

  FavoriteState copyWith({List<Pokemon>? favorites}) {
    return FavoriteState(favorites: favorites ?? this.favorites);
  }
}
