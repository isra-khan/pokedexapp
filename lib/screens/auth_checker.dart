import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/cubit/auth_cubit.dart';
import 'package:pokedex/cubit/pokemon__cubit.dart';
import 'package:pokedex/screens/homescreen.dart';
import 'package:pokedex/screens/login_screen.dart';
import 'package:pokedex/screens/pokemon_screen.dart';

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, bool>(
      builder: (context, isAuthenticated) {
        return isAuthenticated
            ? BlocProvider(
                create: (context) => PokemonListCubit(),
                child: PokemonListApp(),
              )
            : LoginForm();
      },
    );
  }
}
