// favorite_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/cubit/favourite_cubit.dart';
import 'package:pokedex/cubit/favourite_state.dart';
import 'package:pokedex/cubit/pokemon__cubit.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Pokemon'),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state.favorites.isEmpty) {
            return Center(
              child: Text('No favorites selected.'),
            );
          }

          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final favoritePokemon = state.favorites[index];
              return ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      favoritePokemon.imageUrl,
                      height: 100,
                    ),
                    Text(
                      favoritePokemon.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey.withOpacity(1)),
                    ),
                  ],
                ),
                leading: Text(
                  index.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.withOpacity(1)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
