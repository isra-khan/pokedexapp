import 'package:flutter/material.dart';
import 'package:pokedex/cubit/auth_cubit.dart';
import 'package:pokedex/cubit/favourite_cubit.dart';
import 'package:pokedex/cubit/favourite_state.dart';
import 'package:pokedex/cubit/pokemon__cubit.dart';
import 'package:pokedex/cubit/pokemon_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/screens/favourite_screen.dart';
import '../cubit/auth_cubit.dart';

// main.dart
// ... (previous code)

// main.dart
// ... (previous code)

class PokemonListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokedex App',
          style: TextStyle(color: Colors.purple),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.purple,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contexts) => BlocProvider.value(
                      value: contexts.read<FavoriteCubit>(),
                      child:
                          FavoriteScreen()), // Use the correct screen widget here
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.logout_sharp,
              color: Colors.purple,
            ),
            onPressed: () {
              AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
              authCubit.logout();
            },
          ),
        ],
      ),
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
        builder: (context, state) {
          if (state is PokemonListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PokemonListLoaded) {
            return PokemonList(pokemonList: state.pokemonList);
          } else if (state is PokemonListError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state is PokemonListFavorites) {
            return PokemonList(pokemonList: state.favoritePokemonList);
          } else {
            return Center(
                child: Text('Press the button to fetch Pokemon list.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PokemonListCubit>().fetchPokemonList();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
// pokemon_list.dart

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemonList;

  PokemonList({required this.pokemonList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemCount: pokemonList.length,
      itemBuilder: (context, index) {
        final pokemon = pokemonList[index];
        return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  pokemon.imageUrl,
                  height: 100,
                ),
                Text(
                  pokemon.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.grey.withOpacity(1)),
                ),
              ],
            ),
            leading: Text(
              ' ${pokemon.id}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.withOpacity(1)),
            ),
            trailing: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, favoriteState) {
              final isFavorite = favoriteState.favorites.contains(pokemon);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  context.read<FavoriteCubit>().toggleFavorite(pokemon);
                },
              );
            }));
      },
    );
  }
}
