import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/bloc/favoritos_bloc.dart';
import 'package:closeup/bloc/filmes_bloc.dart';
import 'package:closeup/bloc/generos_bloc.dart';
import 'package:closeup/screens/genero_list_screen.dart';
import 'package:closeup/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(CloseUpApp());

class CloseUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: FilmesBloc(),
        child: BlocProvider(
          bloc: FavoritosBloc(),
          child: BlocProvider(
              bloc: GenerosBloc(),
              child: MaterialApp(
                title: "Close-Up",
                theme: ThemeData.dark(),
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
              )),
        ));
  }
}
