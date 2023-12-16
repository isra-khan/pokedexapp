import 'package:flutter/material.dart';
import 'package:pokedex/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
              authCubit.logout();
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
