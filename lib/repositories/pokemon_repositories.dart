// pokemon_repository.dart
// pokemon_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon_model.dart';

class PokemonRepository {
  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      final List<Pokemon> pokemonList = results
          .asMap()
          .map((index, result) {
            final pokemonId = index + 1;
            return MapEntry(
              pokemonId,
              Pokemon(
                id: pokemonId,
                name: result['name'],
                imageUrl:
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png',
              ),
            );
          })
          .values
          .toList();

      return pokemonList;
    } else {
      throw Exception('Failed to fetch Pokemon list');
    }
  }
}
