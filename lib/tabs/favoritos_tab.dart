import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/bloc/favoritos_bloc.dart';
import 'package:closeup/models/filme.dart';
import 'package:closeup/tile/filme_list_tile.dart';
import 'package:closeup/widgets/wait_load.dart';
import 'package:flutter/material.dart';

class FavoritosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String,Filme>>(
        stream: BlocProvider.of<FavoritosBloc>(context).outFav,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data.values.map((filme) {
                return FilmeListTile(filme);
              }).toList().cast<Widget>(),
            );
          } else {
            return Center(
              child: WaitLoad(),
            );
          }
        });
  }
}
