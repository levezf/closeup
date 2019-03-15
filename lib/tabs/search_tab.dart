import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/bloc/filmes_bloc.dart';
import 'package:closeup/delegates/data_search.dart';
import 'package:closeup/screens/home_screen.dart';
import 'package:closeup/tile/filme_list_tile.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  static const int QUERY_SEARCH = 6;

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.of<FilmesBloc>(context).outFilmes(QUERY_SEARCH),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> childrens = snapshot.data
              .map((filme) {
                return FilmeListTile(filme);
              })
              .toList()
              .cast<Widget>();

          childrens.add(Container(
              margin: EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: () {
                    BlocProvider.of<FilmesBloc>(context)
                        .moreSearch(QUERY_SEARCH, HomeScreen().result);
                  },
                  child: Text("Carregar mais..."))));

          return ListView(
            children: childrens,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
