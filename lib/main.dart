import 'package:flutter/material.dart';
import 'package:pokedex/cubit/auth_cubit.dart';
import 'package:pokedex/cubit/favourite_cubit.dart';
import 'package:pokedex/cubit/pokemon__cubit.dart';
import 'package:pokedex/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<PokemonListCubit>(create: (context) => PokemonListCubit()),
        BlocProvider<FavoriteCubit>(create: (context) => FavoriteCubit()),
        // Add more providers as needed
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My App',
          home: SplashScreen()),
    );
  }
}
